# Automatic Application Deployment in AWS using Terraform

In this project, I harnessed the capabilities of Terraform Provisioners and AWS to automate the deployment of a simple Python Flask application on an Amazon EC2 instance. This solution streamlines the process of deploying applications in the AWS cloud, ensuring efficiency and consistency. By automating infrastructure provisioning, I eliminated manual intervention, reducing potential errors and accelerating deployment time. Additionally, the use of Terraform allowed for version-controlled, repeatable infrastructure setups, making scaling and updates easier to manage. This approach highlights the power of Infrastructure as Code (IaC) in delivering agile, reliable, and scalable cloud-based applications.

## Overview :
![diagram](https://github.com/gopika09/Automatic_Applicatio_Deployment_in_AWS_using_Terraform/blob/main/pictures/Screenshot%202024-10-05%20233406.png)

## Features :

- **Lightweight Framework**: Developed using Flask, enabling rapid development and deployment.
- **RESTful API**: Supports essential CRUD operations for managing resources seamlessly.
- **Database Integration**: Connects to a database (e.g., Amazon RDS) for efficient data storage.
- **Scalability**: Deployed on AWS, allowing for easy scaling and management of resources as needed.

## Tools and Technologies :

- **Flask**: A micro web framework for Python that facilitates quick application development.
- **AWS EC2**: Virtual servers for hosting the application in the cloud.
- **AWS RDS**: A managed relational database service that simplifies database management and scalability.
- **Git**: Version control system for tracking changes in the codebase.
- **AWS VPC**: Provides a secure and isolated network environment for the application.
- **Route 53**: AWS’s scalable domain name system (DNS) service for managing domain names and routing traffic.
- **Elastic Load Balancer (ELB)**: Distributes incoming application traffic across multiple targets, ensuring high availability and reliability.
- **Terraform**: An Infrastructure as Code (IaC) tool used to automate the deployment and management of AWS resources, including EC2 instances, security groups, and networking components, ensuring consistent and repeatable infrastructure provisioning.
 

## Steps to Deploy :



In this project, I begin by defining a **Virtual Private Cloud (VPC)** in the ap-south-1 region, utilizing a variable for the CIDR block `11.0.0.0/16` to maintain flexibility in specifying the network's IP address range. Next, I established two **public subnets** with CIDR blocks `11.0.1.0/24` and `11.0.2.0/24` and 2 private subnets `11.0.3.0/24` and `11.0.4.0/24` with CIDR blocks in availability zones ap-south-1a and ap-south-1b, which facilitate automatic public IP assignment for resources within distinct public subnets. To enable connectivity to the internet, I create an **Internet Gateway** that links the public subnet to external networks and NAT Gateway for private subnet to communicate with internet. Additionally, I configure a **route table** and associate it with the public and private subnets to ensure efficient traffic routing.

![diagram](https://github.com/gopika09/Automatic_Applicatio_Deployment_in_AWS_using_Terraform/blob/main/pictures/vpc.png)

![diagram](https://github.com/gopika09/Automatic_Applicatio_Deployment_in_AWS_using_Terraform/blob/main/pictures/subnets.png)



I then create two **security groups**: one for the EC2 instances, allowing SSH, HTTP, and TCP access at port 5000(python flask app), and another for the database, which permits traffic on port 3306. This configuration enhances security while ensuring that the necessary connections for application functionality are maintained.

![diagram](https://github.com/gopika09/Automatic_Applicatio_Deployment_in_AWS_using_Terraform/blob/main/pictures/sg%20ec2.png)

![diagram](https://github.com/gopika09/Automatic_Applicatio_Deployment_in_AWS_using_Terraform/blob/main/pictures/sg%20database.png)



Next, I launched an **EC2 instance** in one of the subnets using a Linux instance type, attaching it to the VPC and the appropriate security group. To enable secure access, I generated SSH keys using the command prompt with the `ssh-keygen -t rsa` command, incorporating the public key into the EC2 Terraform configuration. This setup ensures secure and seamless access to the instance, and I utilized **user data** to automatically install the Python Flask application on launch.



**User Data Configuration:**

![user_data](https://github.com/gopika09/Automatic_Applicatio_Deployment_in_AWS_using_Terraform/blob/main/pictures/user%20data.png)


I then created a target group for the Elastic Load Balancer, configuring it to use the HTTP protocol on port 5000. I also set up the health check parameters for the target group to ensure that only healthy instances receive traffic. Finally, I registered the EC2 instance with the target group, enabling load balancing for incoming requ

![target_group](https://github.com/gopika09/Automatic_Applicatio_Deployment_in_AWS_using_Terraform/blob/main/pictures/target%20group.png)



Next, I set up the load balancer as an internet-facing application type. I attached the appropriate security group and created a listener on port 80 using the HTTP protocol, linking it to the target group I had previously established. This configuration allows incoming traffic to be effectively routed to my EC2 instances through the load balancer.  

![diagram](https://github.com/gopika09/Automatic_Applicatio_Deployment_in_AWS_using_Terraform/blob/main/pictures/load%20balancer.png)



I then created a db subnet group and associated it with the private subnets. Following that, I launched an RDS instance using MySQL as the database engine, selecting the instance class as "db.t3.micro." I specified the database username, password, and initial database name, ensuring to attach the appropriate security group to the RDS instance for secure access.  

![diagram](https://github.com/gopika09/Automatic_Applicatio_Deployment_in_AWS_using_Terraform/blob/main/pictures/subnet%20group.png)



Next created a public hosted zone in Route 53, naming it "mysite.com." Additionally, I configured an A record in the hosted zone, setting it as an alias to the Elastic Load Balancer. This ensures that traffic directed to "mysite.com" is routed effectively to the load balancer, allowing seamless access to my application.  

![diagram](https://github.com/gopika09/Automatic_Applicatio_Deployment_in_AWS_using_Terraform/blob/main/pictures/public%20hosted%20zone.png)



## Results :

Application level:


![diagram](https://github.com/gopika09/Automatic_Applicatio_Deployment_in_AWS_using_Terraform/blob/main/pictures/application%20level.png)

Database level:


![diagram](https://github.com/gopika09/Automatic_Applicatio_Deployment_in_AWS_using_Terraform/blob/main/pictures/database%20level.png)


## Conclusion:

In this project, I successfully automated the deployment of a Python Flask application on an Amazon EC2 instance using Terraform and AWS. This solution highlights the efficiency of using Terraform Provisioners, streamlining the deployment process. Key features include a RESTful API, seamless database integration with Amazon RDS, and the scalability provided by AWS. I configured a secure Virtual Private Cloud (VPC), implemented an Elastic Load Balancer (ELB) for high availability, and utilized Route 53 for traffic management.Overall, this project demonstrates the effective use of modern development practices and cloud technologies, laying a strong foundation for future enhancements and scalability.









