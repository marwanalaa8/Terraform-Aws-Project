variable "aws_region" { type = string }
variable "project_name" { type = string }

variable "vpc_cidr" { type = string }
variable "public_subnet_cidrs" { type = list(string) }
variable "private_subnet_cidrs" { type = list(string) }

variable "my_ip_cidr" { type = string }
variable "key_name" { type = string }

variable "instance_type_public" { type = string }
variable "instance_type_private" { type = string }

variable "tags" {
  type    = map(string)
  default = {}
}
