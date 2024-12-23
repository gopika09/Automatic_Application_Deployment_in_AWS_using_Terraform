# Variable to store the CIDR block for the VPC
variable "cidr_block" {}

variable "public_cidr_block" {}

variable "private_cidr_block" {}

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

output "public_subnet_id" {
  value = aws_subnet.public_subnet[*].id  # Retrieves all public subnet IDs
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet[*].id  # Retrieves all private subnet IDs
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
  count = length(var.public_cidr_block)                                    
  vpc_id = aws_vpc.main.id                      # Reference to the VPC ID
  cidr_block = var.public_cidr_block[count.index]  # Different CIDR for each Availability Zone
  availability_zone = var.availability_zones[count.index] # Assign AZ for the subnet
  map_public_ip_on_launch = true                 # Automatically assign a public IP to instances

  # Tags for identifying the public subnet
  tags = {
    Name = "Public Subnet for ${local.region} VPC"  # Name of the public subnet
  }
}

# Create Private Subnets within the VPC
resource "aws_subnet" "private_subnet" {
  count = length(var.private_cidr_block)
  vpc_id = aws_vpc.main.id                      # Reference to the VPC ID
  cidr_block = var.private_cidr_block[count.index]  # Different CIDR for each Availability Zone
  availability_zone = var.availability_zones[count.index]   # Assign AZ for the subnet
  

  # Tags for identifying the public subnet
  tags = {
    Name = "Private Subnet for ${local.region} VPC"  # Name of the public subnet
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



# Create the NAT Gateway
resource "aws_nat_gateway" "nat" {
  
  subnet_id     = aws_subnet.public_subnet[0].id
  allocation_id = aws_eip.nat.id
  tags = {
    Name = "NAT gateway for private subnet traffic routing"
  }
}

# Create an Elastic IP for the NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "Elastic IP for NAT Gateway"
  }
}


# Create a Route Table for the Private Subnet
resource "aws_route_table" "private_route_table" {
  
  vpc_id = aws_vpc.main.id                      # Reference to the VPC ID

  # Define a route that sends all outbound traffic to the Internet
  route {
    
    cidr_block = "0.0.0.0/0"                     # Route all traffic to the Internet
    nat_gateway_id = aws_nat_gateway.nat.id    # Reference to the Internet Gateway
  }

  # Tags for identifying the route table
  tags = {
    Name = "Private route table for ${local.region} VPC"  # Name of the public route table
  }
}

# Associate the Private Route Table with the Private Subnet
resource "aws_route_table_association" "private_association" {
  count          = length(aws_subnet.private_subnet)
  subnet_id     = aws_subnet.private_subnet[count.index].id  # Reference to each public subnet ID
  route_table_id = aws_route_table.private_route_table.id   # Reference to the public route table
}




