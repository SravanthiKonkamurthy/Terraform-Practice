output "public-ip" {
    value = aws_instance.dev.public_ip
  
}
output "Private-ip" {
    value=aws_instance.dev.private_ip
  
}