# strapi-on-ec2-alb

# 📘 Task 8: Deploy Strapi on EC2 with ALB using Terraform

## 🎯 Objective
Deploy a Strapi application on an EC2 instance behind an Application Load Balancer (ALB), using Terraform to provision and manage all infrastructure on AWS.

---

## 📁 Project Structure
```
strapi-on-ec2-alb/
│
├── terraform/
│   ├── alb.tf
│   ├── ec2.tf
│   ├── iam.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── variables.tf
│   └── vpc.tf
├── Dockerfile
├── .dockerignore
└── README.md


 🔧 Prerequisites
- AWS account with admin access
- Terraform installed
- Docker installed
- GitHub repository to push your code

---

 🚀 Step-by-Step Guide

### 1. **Initialize Terraform Project**
Make sure you're inside the `terraform` directory:


cd terraform
terraform init
```

---

### 2. **Define Infrastructure**

#### `providers.tf`

provider "aws" {
  region = "us-east-1"
}
```

#### `vpc.tf`
Use an existing or new VPC and subnet.


variable "vpc_id" {}
variable "public_subnet_id" {}

resource "aws_security_group" "strapi_sg" {
  ...
}
```

#### `ec2.tf`

resource "aws_instance" "strapi" {
  ...
  user_data = file("init.sh")  # Docker run command here
}
```

#### `alb.tf`

resource "aws_lb" "strapi_alb" {
  ...
}

resource "aws_lb_target_group" "strapi_tg" {
  port = 1337
  ...
}

resource "aws_lb_listener" "strapi_listener" {
  ...
}

resource "aws_lb_target_group_attachment" "strapi_attachment" {
  ...
}
```

---

### 3. **Build Docker Image & Push to Docker Hub**

docker build -t shashikumar025/strapi-app .
docker push shashikumar025/strapi-app
```

---

### 4. **Deploy with Terraform**

terraform apply
```
Enter values for:
- `key_name`
- `public_subnet_id`

Confirm with `yes`.

---

### 5. **Access Your Application**
Once deployment is complete, copy the `alb_dns` output and open in your browser:

```
http://<alb_dns>:1337
```

---

### 6. **Fixing Common Issues**
- **Unhealthy Target Group**: Ensure your `health_check` is correct and your app is listening on port 1337.
- **Git Large File Error**:
-  Run:

  rm -rf .terraform/
  git rm -r --cached .
  git add .
  git commit -m "Cleaned .terraform directory"
  git push -u origin main


## ✅ Outputs

output "alb_dns" {
  value = aws_lb.strapi_alb.dns_name
}


## 🧹 Cleanup
To destroy resources:

terraform destroy


