variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "availability_zone" {
  type = list(string)
  default = [
    "eu-east-1a",
    "eu-east-1a",
  ]
}

variable "aws_s3_bucket_name" {
  type = string
  default = "frontend-elb-main"
}


variable "vpc_cidr_block" {
  type = string
  default = "10.0.0.0/16"
}


#change this value to the ip address of your device
variable "ec2_cidr_blocks" {
  type = string
  default = "10.0.3.0/24"
}