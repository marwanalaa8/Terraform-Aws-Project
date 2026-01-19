variable "project_name" { type = string }

variable "public_subnet_id" { type = string }
variable "private_subnet_id" { type = string }

variable "bastion_sg_id" { type = string }
variable "private_sg_id" { type = string }

variable "key_name" { type = string }

variable "instance_type_public" { type = string }
variable "instance_type_private" { type = string }

variable "tags" {
  type    = map(string)
  default = {}
}
