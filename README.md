# Automatic Application Deployment in AWS using Terraform

In this project, I harnessed the capabilities of Terraform Provisioners and AWS to automate the deployment of a simple Python Flask application on an Amazon EC2 instance. This solution streamlines the process of deploying applications in the AWS cloud, ensuring efficiency and consistency. By automating infrastructure provisioning, I eliminated manual intervention, reducing potential errors and accelerating deployment time. Additionally, the use of Terraform allowed for version-controlled, repeatable infrastructure setups, making scaling and updates easier to manage. This approach highlights the power of Infrastructure as Code (IaC) in delivering agile, reliable, and scalable cloud-based applications.

## Overview :
![diagram](https://github.com/gopika09/Python_Flask_App_Terraform_Code/blob/main/diagram.png)

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
- **Terraform**: An Infrastructure as Code (IaC) tool used to automate the deployment and management of AWS resources, including EC2 instances, security groups, and networking components, ensuring consistent and repeatable infrastructure provisioning.
 

## Steps to Deploy



In this project, I begin by defining a **Virtual Private Cloud (VPC)** in the ap-south-1 region, utilizing a variable for the CIDR block `11.0.0.0/16` to maintain flexibility in specifying the network's IP address range. Next, I establish two **public subnets** with CIDR blocks `11.0.1.0/24` and `11.0.2.0/24` in availability zones ap-south-1a and ap-south-1b, which facilitate automatic public IP assignment for resources within distinct public subnets. To enable connectivity to the internet, I create an **Internet Gateway** that links the public subnet to external networks. Additionally, I configure a **route table** and associate it with the public subnets to ensure efficient traffic routing.

![VPC Architecture](path_to_image/vpc.png)

---

I then create two **security groups**: one for the EC2 instances, allowing SSH, HTTP, and HTTPS access, and another for the database, which permits traffic on port 3306. This configuration enhances security while ensuring that the necessary connections for application functionality are maintained.

![Security Groups](path_to_image/security_groups.png)

---

Next, I launched an **EC2 instance** in one of the subnets using a Linux instance type, attaching it to the VPC and the appropriate security group. To enable secure access, I generated SSH keys using the command prompt with the `ssh-keygen -t rsa` command, incorporating the public key into the EC2 Terraform configuration. This setup ensures secure and seamless access to the instance, and I utilized **user data** to automatically install the Python Flask application on launch.

---

**User Data Configuration:**

```bash
#!/bin/bash
sudo yum update -y
sudo yum install python3 -y
pip3 install flask

  
## Conclusion
  
In this project, I successfully automated the deployment of a Python Flask application on an Amazon EC2 instance using Terraform and AWS. This solution highlights the efficiency of using Terraform Provisioners, streamlining the deployment process. Key features include a RESTful API, seamless database integration with Amazon RDS, and the scalability provided by AWS. I configured a secure Virtual Private Cloud (VPC), implemented an Elastic Load Balancer (ELB) for high availability, and utilized Route 53 for traffic management.Overall, this project demonstrates the effective use of modern development practices and cloud technologies, laying a strong foundation for future enhancements and scalability.



