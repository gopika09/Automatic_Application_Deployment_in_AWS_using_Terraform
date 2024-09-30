# Variable to store the EC2 instance ID
variable "ec2_example_id" {}

# Variable to store the load balancer DNS name
variable "load_balancer_dns_name" {}

# Variable to store the load balancer zone ID
variable "load_balancer_zone_id" {}

# Create a public hosted zone in Route 53
resource "aws_route53_zone" "example" {
  name    = "mysite.com"  # Replace with your domain name
  comment = "Public hosted zone for example.com"  # Description of the hosted zone
}

# Create an A record in the hosted zone
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.example.zone_id  # Reference to the hosted zone ID
  name     = "www.mysite.com"                 # The name of the A record
  type     = "A"                               # Record type (A record)

  alias {
    name                   = var.load_balancer_dns_name  # Load balancer DNS name for the alias
    zone_id                = var.load_balancer_zone_id   # Zone ID of the load balancer
    evaluate_target_health = true                        # Evaluate health of the target
  }
}

# Output the fully qualified domain name (FQDN) of the A record
output "a_record" {
  value = aws_route53_record.www.fqdn  # FQDN of the created A record
}

# Output the ID of the public hosted zone
output "public_zone_id" {
  value = aws_route53_zone.example.id  # ID of the public hosted zone
}
