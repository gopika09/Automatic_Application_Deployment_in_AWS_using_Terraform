# Variable to store the VPC ID
variable "vpc_id" {}

# Output the ID of the EC2 security group
output "ec2_sg" {
  value = aws_security_group.ssh_http_https_sg.id  # ID of the SSH, HTTP, and HTTPS security group
}

# Output the ID of the database security group
output "database_sg" {
  value = aws_security_group.database_sg.id  # ID of the database security group
}

# Create a Security Group for SSH, HTTP, and HTTPS
resource "aws_security_group" "ssh_http_https_sg" {
  vpc_id = var.vpc_id  # Reference to the VPC ID

  # Ingress rules to allow SSH and HTTP traffic
  ingress {
    from_port   = 22          # Allow SSH traffic on port 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow SSH access from anywhere
    description = "Allow SSH access"  # Description of the rule
  }

  ingress {
    from_port   = 80          # Allow HTTP traffic on port 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP access from anywhere
    description = "Allow HTTP access"  # Description of the rule
  }

  ingress {
    from_port   = 5000        # Allow traffic on port 5000 (e.g., Flask app)
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow access from anywhere
    description = "Allow access to Flask app"  # Description of the rule
  }

  ingress {
    from_port   = 443         # Allow HTTPS traffic on port 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS access from anywhere
    description = "Allow HTTPS access"  # Description of the rule
  }

  egress {
    from_port   = 0           # Allow all outgoing traffic
    to_port     = 0
    protocol    = "-1"        # -1 indicates all protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allow outgoing requests to anywhere
    description = "Allow outgoing requests"  # Description of the rule
  }

  # Tags for identifying the security group
  tags = {
    Name = "SSH and HTTP Security Group"  # Name tag for the security group
  }
}

# Create a Security Group for the database
resource "aws_security_group" "database_sg" {
  vpc_id = var.vpc_id  # Reference to the VPC ID

  # Ingress rule to allow traffic to the database (MySQL)
  ingress {
    from_port   = 3306        # Allow MySQL traffic on port 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.ssh_http_https_sg.id]  # Allow access from the EC2 security group
    description = "Allow access to database"  # Description of the rule
  }

  # Tags for identifying the security group
  tags = {
    Name = "Database Security Group"  # Name tag for the database security group
  }
}
