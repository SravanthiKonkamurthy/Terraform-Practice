terraform {
  backend "s3" {
    bucket = "sravanthi-statefile"
    key    = "day-4/terraform.tfstate"
    region = "us-east-1"
  }
}
