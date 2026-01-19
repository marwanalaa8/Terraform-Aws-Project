data "aws_availability_zones" "azs" {
  state = "available"
}

module "network" {
  source = "./modules/network"

  project_name         = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = data.aws_availability_zones.azs.names
  tags                 = var.tags
}

module "security" {
  source = "./modules/security"

  project_name = var.project_name
  vpc_id       = module.network.vpc_id
  my_ip_cidr   = var.my_ip_cidr
  tags         = var.tags
}

module "compute" {
  source = "./modules/compute"

  project_name          = var.project_name
  public_subnet_id      = module.network.public_subnet_ids[0]
  private_subnet_id     = module.network.private_subnet_ids[0]
  bastion_sg_id         = module.security.bastion_sg_id
  private_sg_id         = module.security.private_sg_id
  key_name              = var.key_name
  instance_type_public  = var.instance_type_public
  instance_type_private = var.instance_type_private
  tags                  = var.tags
}
