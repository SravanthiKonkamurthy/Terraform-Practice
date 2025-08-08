#Creation of vpc
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "sravanthi-vpc"
    }
}
#creation of public subnet
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block =  "10.0.0.0/24"
    tags = {
        Name = "Sravanthi-public-subnet"
    }
  
}
#creation of Private subnet
resource "aws_subnet" "name2" {
    vpc_id = aws_vpc.name.id
    cidr_block =  "10.0.1.0/24"
    tags = {
        Name = "Sravanthi-private-subnet"
    }
  
}

#creation of internet gateway
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
        Name = "cust-IGW"
    }
  
}
#creation of NAT gateway
resource "aws_nat_gateway" "name" {
    connectivity_type = "private"
    subnet_id = aws_subnet.name.id
    tags = {
      Name = "Cust_NAT"
    }
  
}
#creation of Route table and edit routes for NAT
resource "aws_route_table" "name2" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.name.id
    }
}
#creation of subnet association
resource "aws_route_table_association" "name2" {
    subnet_id = aws_subnet.name2.id
    route_table_id = aws_route_table.name2.id
  
}

#creation of Route table and edit routes
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.name.id
    }
}
#creation of subnet association
resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.name.id
    route_table_id = aws_route_table.name.id
  
}
#creation of Security group
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  vpc_id      = aws_vpc.name.id
  tags = {
    Name = "dev_sg"
  }
 ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]
}
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" #all protocols 
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}
#creation of Instance
resource "aws_instance" "name" {
    ami = var.ami-id
    instance_type = var.instance_type
    subnet_id = aws_subnet.name.id
    vpc_security_group_ids = [aws_security_group.allow_tls.id]
    tags = {
        Name = "Sravanthi-instance"
    }
  
}