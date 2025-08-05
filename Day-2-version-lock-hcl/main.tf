resource "aws_instance" "dev" {
    ami = var.ami-id
    instance_type = "t2.micro"
  
}