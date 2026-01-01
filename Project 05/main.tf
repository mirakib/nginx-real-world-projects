provider "aws" {
  region = var.aws_region
}

# VPC

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "nginx-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "nginx-igw"
  }
}

# Availability Zones

data "aws_availability_zones" "available" {}

# Public Subnet (single AZ)

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "nginx-public-subnet"
  }
}

# Private Subnet (single AZ)
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "nginx-private-subnet"
  }
}

# Elastic IP for NAT

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "nginx-nat-eip"
  }
}

# NAT Gateway

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "nginx-nat-gateway"
  }
}

# Public Route Table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "nginx-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Private Route Table

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "nginx-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# Security Group for ALB

resource "aws_security_group" "alb_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-alb-sg"
  }
}

# Security Group for EC2

resource "aws_security_group" "ec2_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nginx-ec2-sg"
  }
}

# Launch Template

resource "aws_launch_template" "nginx" {
  name_prefix   = "nginx-lt"
  image_id      = "ami-0ecb62995f68bb549"
  instance_type = "t2.micro"
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = base64encode(<<-EOF
    #!/bin/bash
    apt update -y
    apt install -y nginx
    systemctl enable nginx
    systemctl start nginx
  EOF
  )

  tags = {
    Name = "nginx-launch-template"
  }
}

# Application Load Balancer

resource "aws_lb" "alb" {
  name               = "nginx-alb"
  load_balancer_type = "application"
  subnets            = [aws_subnet.public.id]
  security_groups    = [aws_security_group.alb_sg.id]

  tags = {
    Name = "nginx-alb"
  }
}

# Target Group

resource "aws_lb_target_group" "tg" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id  = aws_vpc.main.id

  tags = {
    Name = "nginx-tg"
  }
}

# Listener

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# Auto Scaling Group

resource "aws_autoscaling_group" "asg" {
  min_size         = 1
  max_size         = 3
  desired_capacity = 2

  vpc_zone_identifier = [aws_subnet.private.id]
  target_group_arns  = [aws_lb_target_group.tg.arn]

  launch_template {
    id      = aws_launch_template.nginx.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "nginx-auto-sg"
    propagate_at_launch = true
  }
}
