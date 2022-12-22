# Get VPC information from remote state
data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = var.TF_HCP_org_name
    workspaces = {
      name = var.TF_HCP_workspace_name
    }
  }
}

data "aws_ami" "amazon_linux" {
  owners = ["amazon"]

  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "app1" {
  for_each = data.terraform_remote_state.vpc.outputs.VPC_Public_Subnets

  subnet_id = each.value

  key_name = "dudug"
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.VPC_security_group_id]

  root_block_device {
    delete_on_termination = true
    volume_size = 10
    volume_type = "gp2"
  }
  tags = {
    Name = "app1-${each.value}"
    Owner = "David Gidony"
    Env = "Maturity-Workshop"
    Terraform = "True"
  }
user_data = <<-EOF
#! /bin/bash
yum update -y
yum install -y jq
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello World from App1 in subnet: $(hostname -f)</h1>" > /var/www/html/index.html
EOF
}