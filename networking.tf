# VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
}

# Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

# Subnet 1
resource "aws_subnet" "sn1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block[0]
  availability_zone = var.availability_zone[0]
}

# Subnet 2
resource "aws_subnet" "sn2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidr_block[1]
  availability_zone = var.availability_zone[1]
}

# Security Group for the load balancer
resource "aws_security_group" "elb_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  #Allow HTTPS from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #Allow HTTP from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for the ec2 instances / auto scaling group
resource "aws_security_group" "ec2_asg_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  #Allow HTTPS from the load balancer
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_lb.main.id]
  }

  #Allow HTTP from the load balancer
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_lb.main.id]
  }
}

