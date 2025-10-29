🌩️ Terraform AWS Infrastructure — Remote Backend + CI/CD (GitHub Actions)
🚀 Overview

This project automates the provisioning of AWS infrastructure using Terraform with a fully configured remote backend (S3 + DynamoDB) for state management and a GitHub Actions pipeline for CI/CD automation.

It demonstrates real-world Infrastructure as Code (IaC) practices with versioned deployments, secure state management, and modular architecture.

🧱 Infrastructure Components
Service	Description
VPC	Custom Virtual Private Cloud with public & private subnets
EC2	Compute instance hosted in the public subnet
RDS (MySQL)	Private database instance for application data
S3	Remote Terraform backend for state storage
DynamoDB	Used for Terraform state locking
Security Groups	Custom firewall rules for controlled traffic
Terraform Modules	Modularized structure for reusability and clarity

⚙️ Project Architecture
terraform-aws-infra/
├── main.tf
├── backend.tf
├── provider.tf
├── variables.tf
├── output.tf
├── modules/
│   ├── network/
│   ├── compute/
│   └── database/
└── .github/
    └── workflows/
        └── terraform.yml

🧩 Terraform Backend (S3 + DynamoDB)

State management and locking are configured to ensure collaborative and consistent Terraform runs.

terraform {
  backend "s3" {
    bucket         = "deepam-terraform-state-bucket-backend"
    key            = "infra/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock-deepam"
    encrypt        = true
  }
}

🔄 CI/CD Pipeline (GitHub Actions)

This repository uses a Terraform GitHub Actions workflow that performs:

terraform fmt — syntax and style checks

terraform init — backend initialization

terraform validate — config validation

terraform plan — infra planning

terraform apply (optional) — auto-deployment to AWS

📂 Workflow file: .github/workflows/terraform.yml

name: Terraform CI/CD Pipeline

on:
  push:
    branches: [ "main" ]

jobs:
  terraform:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.8.0

      - name: Terraform Init
        run: terraform init

      - name: Terraform Validate
        run: terraform validate

      - name: Terraform Plan
        run: terraform plan -input=false

🔐 GitHub Secrets Required

Add the following under Repo → Settings → Secrets and variables → Actions:

Secret Name	Description
AWS_ACCESS_KEY_ID	IAM access key for Terraform
AWS_SECRET_ACCESS_KEY	Secret key for Terraform
AWS_REGION	Default region (ap-south-1)
🧠 How to Run Locally
# 1️⃣ Initialize Terraform
terraform init -reconfigure

# 2️⃣ Validate syntax
terraform validate

# 3️⃣ Plan resources
terraform plan

# 4️⃣ Apply changes
terraform apply -auto-approve

🌍 Deployment Output

After successful deployment, Terraform outputs:

vpc_id          = vpc-xxxxxx
ec2_public_ip   = 13.xxx.xxx.xxx
db_endpoint     = terraform-db.xxxxx.ap-south-1.rds.amazonaws.com

🧰 Tech Stack

Terraform v1.8+

AWS (EC2, RDS, S3, DynamoDB, VPC)

GitHub Actions

IAM for secure access management

🧩 Key Learning Outcomes

✅ End-to-end AWS provisioning using Terraform
✅ Secure remote state management (S3 + DynamoDB)
✅ CI/CD automation with GitHub Actions
✅ Modularized Terraform project design

🧑‍💻 Author

👤 Deepam Chavhan
📍 Pune, Maharashtra
📧 deepamchavhan777@gmail.com

🌐 LinkedIn
