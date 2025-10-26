terraform {
  backend "s3" {
    bucket       = "deepam-terraform-state-bucket-backend" # Must exist before init
    key          = "rds/mysql/terraform.tfstate"           # Path within the bucket
    region       = "ap-south-1"
    use_lockfile = true # Optional: for state locking
    encrypt      = true
  }
}
