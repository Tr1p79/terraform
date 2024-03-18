terraform {
  backend "s3" {
    bucket = "tp-terra"
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"
  }
}