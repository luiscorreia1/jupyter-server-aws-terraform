variable "deb-based" {
  type = string
  default = "ami-0557a15b87f6559cf"
}
variable "avail-zone" {
  type = string
  default = "us-east-1a"
}

variable "jupyter-type" {
  type = string
  default = "t2.small"
}

variable "vpc-ep-svc-name" {
  type = string
  default = "com.amazonaws.us-east-1.s3"
}
