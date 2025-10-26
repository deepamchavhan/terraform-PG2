
output "instance_public_ip" {
  value = aws_instance.app.public_ip
}

output "sg_id" {
  value = aws_security_group.ec2_sg.id
}
