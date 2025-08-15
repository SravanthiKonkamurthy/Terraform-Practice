provider "aws" {
  
}
module "test" {
    source = "../Day-7-Rdsdb"
    allocated_storage = 20
    storage_type = "gp2"
    engine = "mysql"
    engine_version = "8.0"
    instance_class = "db.t3.micro"
    db_name = "dev-dbb"
    identifier = "my-dev-dbb"
    username = "admin"
    password = "StrongPassword!"
    publicly_accessible = true
    name = "my-subnet-group"
    subnet_ids = [subnet-011e09399ca140fea,subnet-07b9ed4739dd0deba]
    vpc_id = "vpc-0323b79a097ca6941"
    aws_security_group_name = "my-sg"
    name1 = "my-db"

  
}