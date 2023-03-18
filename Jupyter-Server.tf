resource "aws_instance" "jupyter" {
  ami                                  = var.deb-based
  instance_type                        = var.jupyter-type
  key_name                             = aws_key_pair.jupyter.key_name
  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.jupyter-public1.id
  }
  network_interface {
    device_index         = 1
    network_interface_id = aws_network_interface.jupyter-private1.id
  }
  tags                                 = {
    "Name" = "jupyter"
  }
  root_block_device {
    delete_on_termination = true
    tags                                 = {
      "Name" = "Volume for jupyter"
    }
    volume_size           = 30
    volume_type           = "gp2"
  }
  user_data = data.template_file.jupyter.rendered
}
resource "aws_network_interface" "jupyter-public1" {
  private_ips         = ["10.0.0.10"]
  security_groups    = [
    aws_security_group.jupyter-default.id,
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.jupyter-public1.id
  tags                                 = {
    "Name" = "jupyter public interface"
  }
}
resource "aws_eip" "jupyter-public-ip" {
  vpc                       = true
  network_interface         = aws_network_interface.jupyter-public1.id
  tags                                 = {
    "Name" = "jupyter public IP"
  }
  depends_on = [
    aws_instance.jupyter
  ]
}
resource "aws_network_interface" "jupyter-private1" {
  private_ips         = ["10.0.1.10"]
  security_groups    = [
    aws_security_group.jupyter-default.id,
  ]
  source_dest_check  = false
  subnet_id          = aws_subnet.jupyter-private1.id
  tags                                 = {
    "Name" = "jupyter private1 interface"
  }
}