# Specify the AWS provider and region
provider "aws" {
  region     = "ap-south-1"  # Specify your desired AWS region
  access_key = "*******************"  # AWS Access Key
  secret_key = "************************"  # AWS Secret Key
}

# Module for networking setup (VPC, subnets, etc.)
module "networking" {
  source              = "./networking"
  cidr_block          = var.cidr_block
  availability_zones  = var.availability_zones  # Availability zones for the VPC
  public_cidr_block   = var.public_cidr_block
  private_cidr_block  = var.private_cidr_block
}

# Module for creating security groups
module "security_groups" {
  source     = "./security_groups"
  vpc_id     = module.networking.vpc_id  # VPC ID from the networking module
}

# Module for launching EC2 instances
module "ec2_instance" {
  source            = "./ec2_instance"
  ami               = var.ami  # AMI ID for the EC2 instance
  instance_type     = var.instance_type  # Type of EC2 instance
  public_subnet_id  = module.networking.public_subnet_id  # Public subnet ID for the instance
  security_groups   = [module.security_groups.ec2_sg, module.security_groups.database_sg]  # Security groups
  public_key        = var.public_key  # Public SSH key for access
  user_data_install_python_app = templatefile("./template/install_python_app.sh", {})  # User data for instance initialization
}

# Module for setting up the load balancer
module "load_balancer" {
  source                = "./load_balancer"
  ec2_sg                = module.security_groups.ec2_sg  # Security group for the load balancer
  target_group_arn      = module.load_balancer_target_group.target_group_arn  # Target group ARN
  ec2_example_id        = module.ec2_instance.ec2_example_id  # EC2 instance ID
  subnet_ids            = module.networking.public_subnet_id  # Subnet IDs for the load balancer
}

# Module for creating the load balancer target group
module "load_balancer_target_group" {
  source                = "./load_balancer_target_group"
  vpc_id                = module.networking.vpc_id  # VPC ID for the target group
  ec2_example_id        = module.ec2_instance.ec2_example_id  # EC2 instance ID
  availability_zones    = var.availability_zones  # Availability zones for the target group
}

# Module for Route 53 DNS configuration
module "route_53" {
  source                        = "./route_53"
  ec2_example_id                = module.ec2_instance.ec2_example_id  # EC2 instance ID for routing
  load_balancer_dns_name        = module.load_balancer.load_balancer_dns_name  # DNS name of the load balancer
  load_balancer_zone_id         = module.load_balancer.load_balancer_zone_id  # Zone ID of the load balancer
}

# Module for setting up the database
module "database" {
  source                = "./database"
  database_sg          = module.security_groups.database_sg  # Security group for the database
  private_subnet_id    = module.networking.private_subnet_id
}
