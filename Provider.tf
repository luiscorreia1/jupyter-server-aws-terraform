terraform {
  required_version = ">= 1.3.9"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.56.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "unlimited"
}


resource "aws_key_pair" "jupyter" {
  key_name   = "jupyter"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbS14I+JUb0EBXbOIdl1P0wXZYPksl76xLbbdbksCHRazpqeJ61Ksqy+BUy9rMJkmTNHqyR/Y3BOnmfKcSaxuPBLEWRgQuPcaTDmwAuXbQUcRLJd4BK7YedH+APTnzMVRvbIfszJmFo8KgQXNYOOkUaicoSt3q6U7Udaqh4Y2X5BGal+PxHjuVs8iZUg9qDiWToqYHvERO/O85DqgQGVGpsr2cxzx3p1fuioRs2ybJIqSo0r1boSexkCmwBl2nxo9v2Rk0QLs4vb67DVOvTfgis9hYLswsdQgXCs+tVzL579gRaLm+rwTHokt2Am60dQL+IW3Ayy85n0zw+DeF7qQD"
}
