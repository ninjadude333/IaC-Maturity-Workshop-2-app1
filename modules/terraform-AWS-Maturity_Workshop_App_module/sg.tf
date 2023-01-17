resource "aws_security_group" "app-sg" {
  name        = "${var.Phase}-${var.app_name}-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = var.vpc_id
  tags        = local.tags
}

resource "aws_security_group_rule" "SSH" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "SSH"

  security_group_id = aws_security_group.app-sg.id
}

resource "aws_security_group_rule" "HTTP" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  description = "HTTP"

  security_group_id = aws_security_group.app-sg.id
}


resource "aws_security_group_rule" "egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.app-sg.id
}