resource "aws_s3_bucket" "main" {
    bucket = var.aws_s3_bucket_name
}


resource "aws_lb" "elb-main" {
    name = var.aws_lb_name
    internal = false
    load_balancer_type = "application"
    security_groups = 
    subnets = 

    enable_deletion_protection = true

    access_logs {
        bucket  = aws_s3_bucket.main.id
        prefix  = "aws-lb-main-access-logs"
        enabled = true
    }

    tags = {
        description = "access logs for the aws load balancer"
    }
}