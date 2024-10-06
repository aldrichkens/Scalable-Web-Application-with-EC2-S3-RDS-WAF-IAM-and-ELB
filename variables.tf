variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "availability_zone" {
  type = list(string)
  default = [
    "eu-east-1a",
    "eu-east-1b"
  ]
}

variable "aws_s3_bucket_name" {
  type    = string
  default = "frontend-elb-main"
}


variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  type = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]
}

variable "launch_template_ebs_volume_size" {
  type = number
  default = 8
}

variable "launch_template_ebs_deleteontermination" {
  type = bool
  default = true
}

variable "launch_template_ebs_encrypted" {
  type = bool
  default = false
}

variable "launch_template_ebs_iops" {
  type = number
  default = 3000
}

variable "launch_template_ebs_volume_type" {
  type = string
  default = "gp3"
}

variable "launch_template_ebs_throughput" {
  type = number
  default = 125
}

variable "launch_template_ec2_user_data" {
  #change the value of this when we get to the deployment stage
  type = string
  default = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install apache -y
  EOF
}

variable "launch_template_instance_type" {
  type = string
  default = "t2.micro"
}

variable "launch_template_image_id" {
  type = string
  default = "ami-0fff1b9a61dec8a5f"
}