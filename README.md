# Car Rental System with Terraform

---

### **Project Description**
This project automates the deployment of a car rental system's infrastructure on AWS using Terraform. It provisions and configures all necessary resources, including application servers, a database, a load balancer, and DNS records, to host and run the application seamlessly.

---

### **Provisioned Resources**

#### **1. Security Groups**
- **ALB Security Group (`aws_security_group.alb-sg`)**:
  - Allows inbound HTTP (port 80) traffic from the internet.
  - Allows all outbound traffic.

- **EC2 Security Group (`aws_security_group.ec2-sg`)**:
  - Allows inbound HTTP (port 80) traffic from the ALB.
  - Allows inbound SSH (port 22) traffic from anywhere (for debugging purposes).
  - Allows all outbound traffic.

- **RDS Security Group (`aws_security_group.db-sg`)**:
  - Allows inbound MySQL (port 3306) traffic from EC2 instances.
  - Allows all outbound traffic.

---

#### **2. Application Servers**
- **Launch Template (`aws_launch_template.rental-lt`)**:
  - Defines the configuration for EC2 instances, including:
    - AMI: Ubuntu 24.
    - Instance type: `t2.micro`.
    - Security group: `ec2-sg`.
    - User data script for application setup and configuration.
  - Tags the instances for easy identification.

- **Auto Scaling Group (`aws_autoscaling_group.app-asg`)**:
  - Automatically scales EC2 instances based on demand.
  - Minimum instances: 1.
  - Maximum instances: 3.
  - Desired capacity: 2.
  - Associates the instances with the ALB target group.

---

#### **3. Load Balancer**
- **Application Load Balancer (`aws_alb.app-lb`)**:
  - Distributes incoming HTTP traffic across EC2 instances.
  - Publicly accessible with an IPv4 address.

- **ALB Listener (`aws_alb_listener.app-listener`)**:
  - Listens for HTTP traffic on port 80 and forwards it to the target group.

- **ALB Target Group (`aws_alb_target_group.app-lb-tg`)**:
  - Defines the EC2 instances as targets for the ALB.
  - Configures health checks to monitor instance health.

---

#### **4. Database**
- **RDS Instance (`aws_db_instance.db-server`)**:
  - MySQL 8.0 database instance.
  - Instance type: `db.t3.micro`.
  - Allocated storage: 20 GB.
  - Private access only (not publicly accessible).
  - Configured with a security group (`db-sg`) to allow traffic only from EC2 instances.

- **RDS Subnet Group (`aws_db_subnet_group.default`)**:
  - Ensures the RDS instance is deployed in private subnets.

---

#### **5. DNS Management**
- **Route 53 Record (`aws_route53_record.rental`)**:
  - Creates an A record for `www.erkanbaran.me` in the Route 53 hosted zone.
  - Points the domain to the ALB.

---

#### **6. GitHub Integration**
- **GitHub Repository File (`github_repository_file.env_file`)**:
  - Automatically uploads a [`.env`](.env ) file containing the database endpoint (`DB_HOST`) to the specified GitHub repository.

---

### **How to Deploy**

#### **1. Prerequisites**
- Install Terraform:
  ```bash
  sudo apt-get install terraform
  ```
- Configure AWS CLI:
  ```bash
  aws configure
  ```

#### **2. Configure Variables**
- Update the `terraform.tfvars` file with the required values:
  ```hcl
  key-name = "your-key-name"
  hosted-zone = "erkanbaran.me"
  git-user = "your-github-username"
  repo-name = "car-rental-system-with-terraform"
  dbname = "araba_kiralama"
  dbuser = "admin"
  dbsifre = "your-db-password"
  app-name = "araba_kiralama"
  domain-name = "erkanbaran.me"
  ```

#### **3. Initialize and Apply Terraform**
- Initialize Terraform:
  ```bash
  terraform init
  ```
- Plan and apply the infrastructure:
  ```bash
  terraform plan
  terraform apply
  ```

#### **4. Verify Deployment**
- Access the application at `www.erkanbaran.me` to verify that the infrastructure and application are working correctly.

---

### **Project Structure**

- **`main.tf`**: Defines all AWS resources, including security groups, EC2 instances, ALB, RDS, and Route 53 records.
- **`variable.tf`**: Declares variables used throughout the Terraform configuration.
- **`terraform.tfvars`**: Assigns values to the declared variables.
- **`userdata.sh`**: A script that configures EC2 instances, installs dependencies, and sets up the application.
- **`nginx.template`**: A template for the Nginx configuration file.
- **`gunicorn.service.template`**: A template for the Gunicorn systemd service file.

---

### **Notes**
- Sensitive data such as database passwords should be managed using a secret manager (e.g., AWS Secrets Manager).
- For production environments, consider using an S3 bucket and DynamoDB table for Terraform state management (examples are commented out in the [`terraform/main.tf`](terraform/main.tf ) file).

This project provides a fully automated infrastructure setup for a car rental system, ensuring scalability, reliability, and ease of management.

---

### **Additional Note**
The Terraform solution files for this project have been added to the `terraform` directory.



