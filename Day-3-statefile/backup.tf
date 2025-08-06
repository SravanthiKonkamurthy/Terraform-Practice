terraform {
  backend "s3" {
    bucket         = "sravanthi-tfstate-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
     }
}