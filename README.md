# Python_Flask_App_Terraform_Code

In this project, I harnessed the capabilities of Terraform Provisioners and AWS to automate the deployment of a simple Python Flask application on an Amazon EC2 instance. This solution streamlines the process of deploying applications in the AWS cloud, ensuring efficiency and consistency.

## Features

- **Lightweight Framework**: Developed using Flask, enabling rapid development and deployment.
- **RESTful API**: Supports essential CRUD operations for managing resources seamlessly.
- **Database Integration**: Connects to a database (e.g., Amazon RDS) for efficient data storage.
- **Scalability**: Deployed on AWS, allowing for easy scaling and management of resources as needed.

## Tools and Technologies

- **Flask**: A micro web framework for Python that facilitates quick application development.
- **AWS EC2**: Virtual servers for hosting the application in the cloud.
- **AWS RDS**: A managed relational database service that simplifies database management and scalability.
- **Git**: Version control system for tracking changes in the codebase.
- **AWS VPC**: Provides a secure and isolated network environment for the application.
- **Route 53**: AWS’s scalable domain name system (DNS) service for managing domain names and routing traffic.
- **Elastic Load Balancer (ELB)**: Distributes incoming application traffic across multiple targets, ensuring high availability and reliability.

## Steps to Deploy

1. **Create a VPC**:
   - Launch a new Virtual Private Cloud (VPC) to provide a secure and isolated network environment.
   - Configure subnets (public and private) as needed for your application.

2. **Launch EC2 Instance**:
   - Choose an Amazon Machine Image (AMI) and instance type.
   - Configure security groups to allow HTTP/HTTPS traffic and SSH access.
   - Ensure the EC2 instance is launched within the created VPC and assigned to the appropriate subnet.

3. **Set Up an Elastic Load Balancer (ELB)**:
   - Create an ELB to distribute incoming application traffic across multiple EC2 instances.
   - Configure health checks to ensure traffic is only routed to healthy instances.
   - Update security groups to allow traffic from the ELB to the EC2 instances.

4. **Install Dependencies**:
   - SSH into the EC2 instance.
   - Install Python, Flask, and any other required libraries.

5. **Set Up RDS**:
   - Launch a RDS instance for your database.
   - Configure security settings to allow access from your EC2 instance and ensure it is in the same VPC.

6. **Deploy Flask Application**:
   - Clone your application repository to the EC2 instance.
   - Set environment variables and configure database connections.
   - Run the Flask application.

7. **Test the Application**:
   - Use a web browser to verify that the application is running correctly through the ELB endpoint.

8. **Configure Route 53 Domain**:
   - Set up your domain in Route 53.
   - Create an A record that points your domain to the ELB’s DNS name, allowing users to access your application through your custom domain.



