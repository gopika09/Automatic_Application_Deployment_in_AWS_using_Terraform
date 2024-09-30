# Variable to store the Amazon Machine Image (AMI) ID
variable "ami" {}

# Variable to store the EC2 instance type
variable "instance_type" {}

# Variable to store the public subnet ID for the EC2 instance
variable "public_subnet_id" {}

# Variable to store the security groups associated with the EC2 instance
variable "security_groups" {}

# Variable to store the public key for SSH access to the EC2 instance
variable "public_key" {}

# Variable to store the user data script for initializing the Python Flask app
variable "user_data_install_python_app" {}

# Output the ID of the EC2 instance
output "ec2_example_id" {
    value = aws_instance.ec2_example.id  # Reference to the EC2 instance ID
}

# Create an EC2 Instance
resource "aws_instance" "ec2_example" {
  ami           = var.ami                   # Specify the AMI ID for the instance
  instance_type = var.instance_type         # Specify the type of the instance
  subnet_id     = var.public_subnet_id      # Reference to the public subnet ID
  security_groups = var.security_groups      # Attach the specified security group
  user_data     = var.user_data_install_python_app  # User data for initialization
  key_name      = aws_key_pair.key_pair.key_name   # Reference to the key pair for SSH access

  # Tags for identifying the EC2 instance
  tags = {
    Name = "EC2 Instance"                    # Name of the EC2 instance
  }

  # Configure metadata options for the instance
  metadata_options {
    http_endpoint = "enabled"                # Enable the Instance Metadata Service v2 (IMDSv2)
    http_tokens   = "required"               # Require the use of tokens for IMDSv2
  }
}

# Create a Key Pair for SSH access to the EC2 instance
resource "aws_key_pair" "key_pair" {
  key_name   = "aws_ec2_terraform"          # Name of the key pair
  public_key = var.public_key                # The public key for SSH access
}
