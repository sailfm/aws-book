# aws provider variables

variable "aws_profile" {
  default = "default"
}

variable "aws_region" {
  default = "us-east-1"
}

# vpc variables

variable "vpc_cidr" {
  default = "10.0.4.0/22"
}

variable "subnet_1a_cidr" {
  default = "10.0.4.0/24"
}

variable "subnet_1a_az" {
  default = "us-east-1a"
}

# instance variables

variable "aws_ami" {
  default     = "ami-a4dc46db"
  description = "Ubuntu Server 16.04"
}

variable "instance_type" {
  default = "t2.nano"
}

variable "reader_sg_name" {
  default = "reader-sg"
}

variable "reader_sg_description" {
  default = "reader-sg"
}
