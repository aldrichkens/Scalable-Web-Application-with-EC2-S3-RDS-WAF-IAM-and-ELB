terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

#Configure an S3 account
resource "aws_s3_bucket" "main" {
    bucket = var.aws_s3_bucket_name
}

#Configure a load balancer
resource "aws_lb" "main" {
  name               = "frontend-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.sn1.id, aws_subnet.sn2.id]

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.main.id
    prefix  = "/access_logs/"
    enabled = true
  }
}