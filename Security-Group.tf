resource "aws_security_group" "jupyter-default" {
  description = "jupyter default VPC security group"
  egress      = [
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress     = [
    {
      cidr_blocks      = [
        "192.168.0.0/16",
        "172.16.0.0/12",
        "10.0.0.0/8",
      ]
      description      = "RFC 1918"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = true
      to_port          = 0
    },
  ]
  name        = "jupyter default"
  tags        = {
    "Name" = "jupyter"
  }
  vpc_id      = aws_vpc.jupyter-vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  cidr_ipv4              = "0.0.0.0/0"
  description            = "http"
  ip_protocol            = "tcp"
  to_port                = "80"
  from_port              = "80"
  security_group_id      = aws_security_group.jupyter-default.id
  tags                   = {
    "Name" = "http"
  }
}