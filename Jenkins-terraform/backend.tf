terraform {
  backend "s3" {
    bucket = "tp-terra"
    key    = "Jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}
