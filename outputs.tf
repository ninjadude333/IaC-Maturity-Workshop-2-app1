output "instance_ip_addr" {
  value = aws_instance.app1.*.public_ip
}

output "instance_public_dns" {
  value = aws_instance.app1.*.public_dns
}