locals {
    ami = "ami-08a6efd148b1f7504"
    instance_type = "t2.micro"

    
}

resource "aws_instance" "name" {
    ami = local.ami
    instance_type = local.instance_type
  
}