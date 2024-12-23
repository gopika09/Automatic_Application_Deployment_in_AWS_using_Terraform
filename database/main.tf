# Variable to store the database security group
variable "database_sg" {}

variable "private_subnet_id" {}

# Create a DB Subnet Group for RDS
resource "aws_db_subnet_group" "database_subnet_group" {
  
  name       = "database-subnet-group"      # Name of the DB subnet group
  subnet_ids = [var.private_subnet_id[0],  var.private_subnet_id[1]]        # Subnets to associate with the DB subnet group
}

# Create the RDS instance
resource "aws_db_instance" "example" {
  identifier            = "my-database"          # Identifier for the database instance
  engine                = "mysql"                  # Database engine type (MySQL)
  engine_version        = "5.7"                    # Specify the MySQL version
  instance_class        = "db.t3.micro"            # Instance type for the database
  allocated_storage      = 20                       # Storage size in GB
  storage_type          = "gp2"                    # General Purpose SSD
  username              = "admin"                  # Database username
  password              = "17Saythename"           # Database password (consider using a secure method for production)
  db_name               = "sample"                 # Initial database name
  skip_final_snapshot   = true                     # Set to false if you want to take a snapshot before deletion
  vpc_security_group_ids = [var.database_sg]      # Reference to the security group for the database
  db_subnet_group_name  = aws_db_subnet_group.database_subnet_group.name  # Reference to the DB subnet group
  
  # Tags for identifying the RDS instance
  tags = {
    Name = "My Database"                          # Name of the RDS instance
  }
}

# Output the RDS endpoint
output "db_instance_endpoint" {
  value = aws_db_instance.example.endpoint      # Output the endpoint of the RDS instance
}
