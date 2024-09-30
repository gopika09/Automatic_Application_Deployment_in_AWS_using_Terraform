# Variable to store the CIDR block for the VPC
variable "cidr_block" {}

# Variable to store public subnet CIDR blocks
variable "public_cidr_block" {
    type    = list(string)                       # Define as a list of strings
    default = ["11.0.1.0/24", "11.0.2.0/24"]     # Default values for public subnets
}

# Variable to store availability zones
variable "availability_zones" {}

# Define local variables
locals {
    region = "ap-south-1"                       # Specify the AWS region
}

# Output the VPC ID
output "vpc_id" {
  value = aws_vpc.main.id                       # Reference to the VPC ID
}

# Output the IDs of the public subnets
output "public_subnet_id" {
  value = aws_subnet.public_subnet.*.id        # List of public subnet IDs
}

# Create a VPC (Virtual Private Cloud)
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block          # CIDR block for the VPC
  enable_dns_support   = true                    # Enable DNS resolution within the VPC
  enable_dns_hostnames = true                    # Enable DNS hostnames for instances within the VPC

  # Tags for identifying the VPC
  tags = {
    Name = "${local.region}-vpc"                 # Name of the VPC based on region
  }
}

# Create Public Subnets within the VPC
resource "aws_subnet" "public_subnet" {
  count = 2                                      # Create two public subnets
  vpc_id = aws_vpc.main.id                      # Reference to the VPC ID
  cidr_block = var.public_cidr_block[count.index]  # Different CIDR for each Availability Zone
  availability_zone = element(var.availability_zones, count.index)  # Assign AZ for the subnet
  map_public_ip_on_launch = true                 # Automatically assign a public IP to instances

  # Tags for identifying the public subnet
  tags = {
    Name = "Public Subnet for ${local.region} VPC"  # Name of the public subnet
  }
}

# Create an Internet Gateway for the Public Subnet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id                      # Reference to the VPC ID

  # Tags for identifying the Internet Gateway
  tags = {
    Name = "Internet Gateway of ${local.region} VPC"  # Name of the Internet Gateway
  }
}

# Create a Route Table for the Public Subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id                      # Reference to the VPC ID

  # Define a route that sends all outbound traffic to the Internet
  route {
    cidr_block = "0.0.0.0/0"                     # Route all traffic to the Internet
    gateway_id = aws_internet_gateway.igw.id    # Reference to the Internet Gateway
  }

  # Tags for identifying the route table
  tags = {
    Name = "Public route table for ${local.region} VPC"  # Name of the public route table
  }
}

# Associate the Public Route Table with the Public Subnet
resource "aws_route_table_association" "public_association" {
  count          = length(aws_subnet.public_subnet)  # Use the IDs of the public subnets
  subnet_id     = aws_subnet.public_subnet[count.index].id  # Reference to each public subnet ID
  route_table_id = aws_route_table.public_route_table.id   # Reference to the public route table
}