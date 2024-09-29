variable "aws_region" {
  type    = string
  default = "us-east-1"
}


variable "vpc_cidr" {
  type        = string
  description = "default CIDR block for the vpc"
  default     = "10.0.0.0/24"
}

variable "aws_s3_bucket_name" {
    type = string
    default = "main-s3-bucket-staticfiles" #name of the bucket
}

variable "aws_lb_name" {
    type = string
    default = "apploadbalancer"
}