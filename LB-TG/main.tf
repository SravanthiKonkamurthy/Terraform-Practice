provider "aws" {
  region = "us-east-1"
}

# --------------------
# 1. Security Group
# --------------------
resource "aws_security_group" "lb_sg" {
  name        = "lb-sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = "vpc-0945386467ddaf43b" # Replace with your VPC ID

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --------------------
# 2. Load Balancer
# --------------------
resource "aws_lb" "app_lb" {
  name               = "my-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = ["subnet-01e20fe78c418b0bf", "subnet-0961c65df1226fd8c"] # Replace with your public subnets
}

# --------------------
# 3. Target Group
# --------------------
resource "aws_lb_target_group" "app_tg" {
  name     = "my-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0945386467ddaf43b" # Replace with your VPC ID
}

# --------------------
# 4. Listener
# --------------------
resource "aws_lb_listener" "app_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

# --------------------
# 5. EC2 Instances (example 2)
# --------------------
resource "aws_instance" "app_server" {
  count         = 2
  ami           = "ami-08a6efd148b1f7504" # Replace with valid AMI
  instance_type = "t2.micro"
  subnet_id     = "subnet-01e20fe78c418b0bf" # Put one subnet here (different for HA)
  key_name      = "my-key"        # Replace with your key

  tags = {
    Name = "App-Server-${count.index + 1}"
  }
}

# --------------------
# 6. Attach Instances to Target Group
# --------------------
resource "aws_lb_target_group_attachment" "app_attach" {
  count            = length(aws_instance.app_server[*].id)
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = aws_instance.app_server[count.index].id
  port             = 80
}
