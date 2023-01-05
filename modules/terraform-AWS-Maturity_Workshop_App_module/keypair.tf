resource "tls_private_key" "keypair_prv_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.keypair_name
  public_key = tls_private_key.keypair_prv_key.public_key_openssh
}