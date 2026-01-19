# Terraform-AWS-Project Infrastructure with Terraform Modules

This repository contains **Terraform-AWS-Project** implemented using **Terraform Modules** (Network, Security, Compute).
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

| Path | Description |
|------|------------|
| `main.tf` | Root module |
| `providers.tf` | AWS provider configuration |
| `variables.tf` | Global variables |
| `outputs.tf` | Terraform outputs |
| `terraform.tfvars.example` | Example variables file |
| `modules/network/` | VPC, Subnets, IGW, NAT |
| `modules/security/` | Security Groups |
| `modules/compute/` | EC2 Instances |

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

```bash
cp terraform.tfvars.example terraform.tfvars

Edit terraform.tfvars (set my_ip_cidr and key_name).
Run:
```bash
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

## 📤 Outputs
After `terraform apply`, print outputs:

```bash
terraform output

Expected outputs:
public_ip
private_ip
public_http_url

🌐 Access / Verify
Open the web server in your browser:

http://<PUBLIC_IP>

Or test from terminal:

curl -I http://<PUBLIC_IP>

Expected:
HTTP/1.1 200 OK

🧹 Cleanup
terraform destroy

