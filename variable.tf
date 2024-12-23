# Define the CIDR block for the main VPC
variable "cidr_block" {
  type        = string  # Type of the variable
  description = "Main VPC CIDR value"  # Description of the variable's purpose
}

# Define the CIDR blocks for public subnets
variable "public_cidr_block" {
  type        = list(string)  # Type is a list of strings
  description = "Public Subnet CIDR value"  # Description of the variable's purpose
}

# Define the CIDR blocks for private subnets
variable "private_cidr_block" {
  type        = list(string)  # Type is a list of strings
  description = "Private Subnet CIDR value"  # Description of the variable's purpose
}

variable "availability_zones" {
  type        = list(string)  # Type is a list of strings
  description = "Availability zones for VPC"  # Description of the variable's purpose
}

variable "ami" {
  type = string
  description = "ami of EC2"
}

variable "instance_type" { 
  type = string
  description = "Instance type of EC2"
}

variable "public_key" {
  type = string
  description = "public key for SSH access"
}
