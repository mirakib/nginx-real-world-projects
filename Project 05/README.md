# Terraform EC2 Nginx Setup

Highly available **Nginx** setup using an **Application Load Balancer** and **Auto Scaling Group** on **Ubuntu 24.04** with Terraform. Provision a lightweight EC2 instance using Terraform and automatically install & run `Nginx` using **user-data**. Ideal for learning Terraform + AWS basics. 

- Creates a `t2.micro` EC2 instance
- Uses `Ubuntu Linux 24.04` AMI
- Installs and starts `Nginx` automatically
- Exposes `HTTP` (port `80`) to the internet


## How to run it

```sh
terraform init
```

```
terraform plan 
```

```
terraform apply -var="key_name=my-ec2-key"
```
