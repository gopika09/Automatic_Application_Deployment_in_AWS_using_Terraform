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
# Create a systemd service for the Flask app
cat <<EOL | sudo tee /etc/systemd/system/flaskapp.service
[Unit]
Description=Flask App
After=network.target

[Service]
User=ec2-user
Group=ec2-user
WorkingDirectory=/home/ec2-user/your_flask_project
ExecStart=/usr/bin/python3 /home/ec2-user/your_flask_project/app.py --port=5000
Restart=always

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd manager configuration
sudo systemctl daemon-reload

# Start and enable the Flask app service
sudo systemctl start flaskapp
sudo systemctl enable flaskapp
