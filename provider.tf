provider "aws" {
  region = "ap-southeast-1"
}

locals {
  inbound_ports = [80, 22]
  outbound_ports = [80, 443]
}


resource "aws_security_group" "training" {
  name = "training"
  tags = {
    Name = "training"
  }
  description = "allow ssh and http connection"
  vpc_id      = "{your vpc id}"
  
  dynamic "ingress" {
    for_each = local.inbound_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    for_each = local.outbound_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
