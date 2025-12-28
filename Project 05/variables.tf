variable "aws_region" {
  default = "us-east-1"
}

variable "key_name" {
  description = "EC2 key pair name"
}

variable "vpc_id" {
  description = "VPC ID"
}

variable "public_subnets" {
  description = "Public subnet IDs"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet IDs"
  type        = list(string)
}
