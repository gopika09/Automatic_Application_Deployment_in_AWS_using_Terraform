# Variable to store the EC2 security group ID
variable "ec2_sg" {}

# Variable to store the ARN of the Target Group
variable "target_group_arn" {}

# Variable to store the EC2 instance ID
variable "ec2_example_id" {}

# Variable to store the list of subnet IDs
variable "subnet_ids" {}

# Output the DNS name of the Load Balancer
output "load_balancer_dns_name" {
    value = aws_lb.load_balancer.dns_name  # Reference to the Load Balancer's DNS name
}

# Output the Zone ID of the Load Balancer
output "load_balancer_zone_id" {
    value = aws_lb.load_balancer.zone_id    # Reference to the Load Balancer's Zone ID
}

# Create an Application Load Balancer
resource "aws_lb" "load_balancer" {
  name                          = "load-balancer"                   # Name of the Load Balancer
  internal                      = false                               # Indicates this is an internet-facing Load Balancer
  load_balancer_type            = "application"                     # Specifies the type of Load Balancer
  security_groups               = [var.ec2_sg]                      # Reference to the security group for the Load Balancer
  enable_deletion_protection    = false                               # Allows deletion of the Load Balancer
  subnets                       = var.subnet_ids             # List of subnet IDs for Load Balancer placement

  tags = {
    Name = "load_balancer_for_ec2_instance"  # Tags for identifying the Load Balancer
  }
}

# Register the EC2 Instance to the Target Group
resource "aws_lb_target_group_attachment" "load_balancer_target_group" {
  target_group_arn = var.target_group_arn  # Reference to the Target Group's ARN
  target_id        = var.ec2_example_id      # Reference to the EC2 instance ID
  port             = 5000                    # Port for the EC2 instance in the Target Group
}

# Create a Listener for the Load Balancer
resource "aws_lb_listener" "load_balancer_listener_http" {
  load_balancer_arn = aws_lb.load_balancer.arn  # Reference to the Load Balancer's ARN
  port              = 80                          # Port for incoming traffic
  protocol          = "HTTP"                      # Protocol for the listener

  # Default action to forward traffic to the target group
  default_action {
    type             = "forward"                  # Action type
    target_group_arn = var.target_group_arn      # Reference to the Target Group's ARN
  }
}
