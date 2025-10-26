provider "aws" {
  region = "ap-south-1"
}

module "network" {
  source = "./modules/network"

  vpc_cidr              = "10.0.0.0/16"
  vpc_name              = "prod-vpc"
  public_subnet_cidr_1  = "10.0.1.0/24"
  public_subnet_cidr_2  = "10.0.2.0/24"
  private_subnet_cidr_1 = "10.0.3.0/24"
  private_subnet_cidr_2 = "10.0.4.0/24"
  availability_zone_1   = "ap-south-1a"
  availability_zone_2   = "ap-south-1b"
}

module "compute" {
  source        = "./modules/compute"
  ami_id        = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  subnet_id     = module.network.public_subnet_ids[0]
  vpc_id        = module.network.vpc_id
  key_name      = "tute"
  sg_name       = "ec2-sg"
}

module "database" {
  source      = "./modules/database"
  db_username = "admin"
  db_password = "Admin1234"
  db_name     = "devdb"
  sg_id       = module.compute.sg_id
  subnet_ids  = module.network.private_subnet_ids
  vpc_id      = module.network.vpc_id # 👈 pass this here
}
