

terraform {
  backend "s3" {
    bucket         = "deepam-terraform-state-bucket-backend"
    key            = "rds/mysql/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock-deepam" # handles locking
  }
}
