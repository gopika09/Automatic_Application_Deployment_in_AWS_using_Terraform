# CIDR block for the main VPC
cidr_block = "11.0.0.0/16"  # Main VPC CIDR value

# CIDR blocks for public subnets
public_cidr_block = ["11.0.1.0/24", "11.0.2.0/24"]  # Public Subnet CIDR values


# Availability zones for resource deployment
availability_zones = ["ap-south-1a", "ap-south-1b"]  # Specify the availability zones

# Amazon Machine Image (AMI) for the EC2 instance
ami = "ami-08718895af4dfa033"  # AMI ID for the EC2 instance

# Instance type for the EC2 instance
instance_type = "t2.micro"  # Type of EC2 instance

# Public SSH key for accessing the EC2 instance
public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCt+amC1Q1CHdANrrk9j2tRZJJSMHAT3rTCMmixsMom6Wa2ZwcHxN8t/nt0cjXVHOvxYAagHaJAA7Q+xrl8qRx3hU7nZp4hHQTV+Ae3fRINNdqXNwKausz6m/VaMvG5Kya3E/qnDkTQIcJJjT0l1cRxmNWWIyNlAaLv2LV32ewe+CWByl/WWOi2mAA9J1KrZ6GDjzSwWiYYfnQLvzbrF4H8dyQd1vS5M3dRsMGmL5YKiAV2nDlwyZeVQBuaqcAv15RJvwE64klILQuMTKmhNRj30nh786sVLUV+ndImL6fLJDfH5JnRqHC1prmkOV4yvBs2BB52Gc0RQ6NlRuDuWD1B gopika@Gopz"  # Public key for SSH access
