#---------------------------------------------------------------
# VPC
#---------------------------------------------------------------
module "vpc" {
  source      = "../../modules/vpc"
  name        = "epam-leodorov-ebs"
  environment = "learning"

  # VPC
  enable_vpc                           = true
  vpc_name                             = "ec2-ebs"
  vpc_instance_tenancy                 = "default"
  vpc_enable_dns_support               = true
  vpc_enable_dns_hostnames             = true
  vpc_assign_generated_ipv6_cidr_block = false
  vpc_cidr_block                       = "172.16.0.0/16"

  azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnet_cidrs = ["172.16.2.0/24", "172.16.4.0/24", "172.16.6.0/24"]
  public_subnet_cidrs  = ["172.16.1.0/24", "172.16.3.0/24", "172.16.5.0/24"]
  map_public_ip_on_launch = true

  # Internet-GateWay
  enable_internet_gateway = true
  internet_gateway_name   = "ec2-ebs-01-igw"

  # NAT
  enable_nat_gateway = true
  single_nat_gateway = true

  # DHCP
  enable_dhcp                          = false
  vpc_dhcp_options_domain_name         = "ec2.internal"
  vpc_dhcp_options_domain_name_servers = ["AmazonProvidedDNS"]

  # NACLs
  enable_network_acl  = false
  network_acl_ingress = []
  network_acl_egress  = []

  # VPC flow log
  enable_flow_log = false

  tags = tomap({
    "Environment"   = "learning",
    "stack" =  "ebs"
    "Owner"     = "Andrei Leodorov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
  ]
}
