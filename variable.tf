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

/* 
# Define the CIDR blocks for private subnets (currently commented out)
variable "private_cidr_block" {
  type        = lis
