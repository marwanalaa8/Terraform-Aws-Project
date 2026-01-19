# Terraform-AWS-Project Infrastructure with Terraform Modules

This repository contains **Lab2** implemented using **Terraform Modules** (Network, Security, Compute).
It provisions a VPC with public/private subnets, IGW, NAT Gateway, route tables, security groups, and EC2 instances.

## Architecture
- VPC: `10.0.0.0/16`
- Public Subnet: `10.0.0.0/24`
- Private Subnet: `10.0.1.0/24`
- Internet Gateway for public subnet
- NAT Gateway for private subnet outbound access
- Public EC2 (Bastion/Web)
- Private EC2 (Apache)

## Project Structure

terraform-project/
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
└── modules/
├── network/
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
├── security/
│ ├── main.tf
│ ├── variables.tf
│ └── outputs.tf
└── compute/
├── main.tf
├── variables.tf
└── outputs.tf

## Modules
### 1) Network Module
Creates:
- VPC
- Public/Private subnets (using `count`)
- IGW, NAT Gateway + EIP
- Public/Private route tables and associations

### 2) Security Module
Creates:
- Bastion SG: SSH (22) + HTTP (80)
- Private SG: allows SSH/HTTP from Bastion SG only

### 3) Compute Module
Creates:
- Public EC2 (web)
- Private EC2 (apache)

## How to Run
1. Copy tfvars example:
```bash
cp terraform.tfvars.example terraform.tfvars

Edit terraform.tfvars (set my_ip_cidr and key_name).
Run:

terraform init
terraform plan
terraform apply
Proof of Modular Deployment

After apply, resources appear under module paths:

module.network.*
module.security.*
module.compute.*

Example:
module.network.aws_vpc.this
module.security.aws_security_group.bastion
module.compute.aws_instance.public
