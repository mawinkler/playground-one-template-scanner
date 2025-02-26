# #############################################################################
# Create VPC
# #############################################################################
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]

  private_subnet_names = [for i in local.azs : "${var.environment}-private-subnet-${i}"]
  public_subnet_names  = [for i in local.azs : "${var.environment}-public-subnet-${i}"]

  create_database_subnet_group = true

  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  instance_tenancy = "default"

  enable_nat_gateway = true
  single_nat_gateway = true
  create_igw         = true

  map_public_ip_on_launch = true

  tags = {
    Environment   = "${var.environment}"
    Product       = "playground-one"
    Configuration = "nw"
  }
  intra_subnet_tags = {
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
}
