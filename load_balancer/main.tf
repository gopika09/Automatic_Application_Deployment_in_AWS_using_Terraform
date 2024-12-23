# Variable to store the VPC ID
variable "vpc_id" {}

# Variable to store the EC2 instance ID
variable "ec2_example_id" {}

# Variable to store availability zones
variable "availability_zones" {}

# Output the ARN of the Target Group
output "target_group_arn" {
  value = aws_lb_target_group.example.arn  # Reference to the Target Group's ARN
}

# Create a Target Group for the Load Balancer
resource "aws_lb_target_group" "example" {
  name     = "target-group-for-load-balancer"  # Name of the Target Group
  port     = 5000                               # Port on which the service is running
  protocol = "HTTP"                             # Protocol used for communication
  vpc_id   = var.vpc_id                         # Reference to the VPC ID

  # Health check configuration for the Target Group
  health_check {
    path                = "/"                    # Path for the health check
    port                = 5000                   # Port for the health check
    interval            = 30                      # Time (in seconds) between health checks
    timeout             = 5                       # Time (in seconds) to wait for a response
    healthy_threshold  = 2                       # Number of successful checks before marking healthy
    unhealthy_threshold = 2                      # Number of failed checks before marking unhealthy
    matcher             = "200"                  # HTTP status code for a successful response
  }
}

# Register the EC2 Instance to the Target Group
resource "aws_lb_target_group_attachment" "example" {
  target_group_arn = aws_lb_target_group.example.arn  # Reference to the Target Group's ARN
  target_id        = var.ec2_example_id                 # Reference to the EC2 instance ID
  port             = 5000                               # Port for the EC2 instance in the Target Group
}
