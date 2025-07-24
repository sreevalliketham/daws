variable "project" {
    default = "roboshop"
}

variable "environment" {
    default = "dev"
}

variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "us-east-1"
}
