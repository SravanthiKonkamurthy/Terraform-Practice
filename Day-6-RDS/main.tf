# DB Subnet Group
resource "aws_db_subnet_group" "dev_db_subnet_groups" {
  name       = "dev-db-subnet-groups"
  subnet_ids = [
    "subnet-085552d5c09733e34",
    "subnet-0c6f308d771b8c37f"
  ]
  tags = {
    Name = "dev-db-subnet-groups"
  }
}

# Security Group for RDS
resource "aws_security_group" "dev_rds_sgroups" {
  name   = "dev-rds-sgroups"
  vpc_id = "vpc-0c606132518c6f618"
  tags = {
    Name = "dev-rds-sgroups"
  }

  # Allow MySQL traffic from application SG
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
   
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS MySQL Instance
resource "aws_db_instance" "dev_rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "devdb"
  identifier             = "my-db"
  username               = "admin"
  password               = "StrongPassw0rd!"
  skip_final_snapshot    = true
  publicly_accessible    = true

  db_subnet_group_name   = aws_db_subnet_groups.dev_db_subnet_groups.name
  vpc_security_group_ids = [aws_security_groups.dev_rds_sgroups.id]
  depends_on = [ aws_db_subnet_group.dev_db_subnet_group ]

  tags = {
    Name = "dev-rds"
  }
}
# resource "aws_db_instance" "read_replica" {
#     replicate_source_db = aws_db_instance.dev_rds.identifier
#     instance_class = "db.t3.micro"
#     identifier = "my-read-replica"

  
# }