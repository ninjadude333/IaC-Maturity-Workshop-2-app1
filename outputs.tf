output "instance_public_ip" {
  value = values(aws_instance.app1).*.public_ip
}

output "instance_public_dns" {
  value = values(aws_instance.app1).*.public_dns
}