provider "aws" {
  region = "ap-southeast-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "k8s_node" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t3.small"
  key_name               = "PJ"
  vpc_security_group_ids = ["sg-0a040f3765c98d133"]

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "k8s-node"
  }
}

output "k8s_node_public_ip" {
  value = aws_instance.k8s_node.public_ip
}
