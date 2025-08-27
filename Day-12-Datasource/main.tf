data "aws_subnet" "name" {
    filter {
      name = "tag:Name"
      values = ["dev"]
    }
  
}
resource "aws_instance" "name" {
    ami = "ami-08a6efd148b1f7504"
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.name.id

  
}
