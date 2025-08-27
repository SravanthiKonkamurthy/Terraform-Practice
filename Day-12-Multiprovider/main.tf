provider "aws" {
    region = "us-west-1"
    alias = "dev"
  
}
provider "aws" {
    region = "us-east-1"
    alias = "prod"
  
}
resource "aws_instance" "name" {
    ami = "ami-08a6efd148b1f7504"
    instance_type = "t2.micro"
    provider = aws.dev
  
}
resource "aws_s3_bucket" "name" {
    bucket = "sravsbucketttttttttttt"
    provider = aws.prod
  
}

