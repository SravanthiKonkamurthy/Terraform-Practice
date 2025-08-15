module "test" {
    source = "../Day-7-Module-source"
    ami-id = "ami-08a6efd148b1f7504"
    instance_type = "t2.micro"
    Name = "sravanthi-EC2"
  
}