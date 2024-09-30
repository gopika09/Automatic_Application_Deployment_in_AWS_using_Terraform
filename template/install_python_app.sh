#!/bin/bash

# Update the package manager and install necessary packages
yum update -y  # Update all packages to the latest version
yum install -y python3 python3-pip git  # Install Python, pip, and Git

# Clone the Git repository to the desired location
git clone https://github.com/gopika09/terraform-project.git /home/ec2-user/your_flask_project  # Clone the Flask project repository

# Navigate to the project directory
cd /home/ec2-user/your_flask_project  # Change directory to the cloned project

# Install Flask and other dependencies
pip3 install -r requirements.txt  # Install Python packages listed in requirements.txt

# Create a systemd service for the Flask app
cat <<EOL > /etc/systemd/system/flaskapp.service
[Unit]
Description=Flask App  # Description of the service
After=network.target  # Ensure network is up before starting the service

[Service]
User=ec2-user  # Run the service as the ec2-user
Group=ec2-user  # Group for the service
WorkingDirectory=/home/ec2-user/your_fla
