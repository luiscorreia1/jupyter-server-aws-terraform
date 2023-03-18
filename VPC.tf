resource "aws_vpc" "jupyter-vpc" {
  cidr_block                           = "10.0.0.0/16"
  tags                                 = {
    "Name" = "jupyter-vpc"
  }
}
resource "aws_subnet" "jupyter-public1" {
  availability_zone                              = var.avail-zone
  cidr_block                                     = "10.0.0.0/24"
  tags                                           = {
    "Name" = "jupyter-subnet-public1"
  }
  vpc_id                                         = aws_vpc.jupyter-vpc.id
}
resource "aws_subnet" "jupyter-private1" {
  availability_zone                              = var.avail-zone
  cidr_block                                     = "10.0.1.0/24"
  tags                                           = {
    "Name" = "jupyter-subnet-private1"
  }
  vpc_id                                         = aws_vpc.jupyter-vpc.id
}

resource "aws_internet_gateway" "jupyter-igw" {
  tags     = {
    "Name" = "jupyter-igw"
  }
  vpc_id   = aws_vpc.jupyter-vpc.id
}

resource "aws_route_table" "jupyter-public1" {
  vpc_id = aws_vpc.jupyter-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jupyter-igw.id
  }
  tags             = {
    "Name" = "jupyter-rtb-public"
  }
}

resource "aws_route_table_association" "jupyter-public1" {
  route_table_id = aws_route_table.jupyter-public1.id
  subnet_id      = aws_subnet.jupyter-public1.id
}

resource "aws_route_table" "jupyter-private1" {
  tags             = {
    "Name" = "jupyter-rtb-cyber_private1"
  }
  vpc_id           = aws_vpc.jupyter-vpc.id
}

resource "aws_route_table_association" "jup-private1" {
  route_table_id = aws_route_table.jupyter-private1.id
  subnet_id      = aws_subnet.jupyter-private1.id
}


resource "aws_vpc_endpoint" "jupyter-vpce-s3" {
  policy                = jsonencode(
    {
      Statement = [
        {
          Action    = "*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "*"
        },
      ]
      Version   = "2008-10-17"
    }
  )
  route_table_ids       = [
    aws_route_table.jupyter-private1.id,
  ]
  service_name          = var.vpc-ep-svc-name
  tags                  = {
    "Name" = "jupyter-vpce-s3"
  }
  vpc_endpoint_type     = "Gateway"
  vpc_id                = aws_vpc.jupyter-vpc.id
}