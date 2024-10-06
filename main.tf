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

resource "aws_s3_bucket" "main" {
  bucket = var.aws_s3_bucket_name
}

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

resource "aws_launch_template" "ec2_asg" {
  name = "launch-template-v1"

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = var.launch_template_ebs_volume_size
      delete_on_termination = var.launch_template_ebs_deleteontermination
      encrypted = var.launch_template_ebs_encrypted
      iops = var.launch_template_ebs_iops
      volume_type = var.launch_template_ebs_volume_type
      throughput = var.launch_template_ebs_throughput
    }
  }

  image_id = var.launch_template_image_id
  instance_type = var.launch_template_instance_type
  security_group_names = [aws_security_group.ec2_asg_sg.id]
  user_data = var.launch_template_ec2_user_data
}


resource "aws_autoscaling_group" "ec2_asg" {
  availability_zones = var.availability_zone
  desired_capacity   = 2
  max_size           = 4
  min_size           = 1

  launch_template {
    id      = aws_autoscaling_group.ec2_asg.id
    version = "$Latest"
  }
}