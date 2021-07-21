data "aws_subnet" "public" {
  for_each = toset(module.vpc.public_subnets_ids)

  id = each.key
  depends_on = [
    module.vpc
  ]
}

data "aws_subnet" "private" {
  for_each = toset(module.vpc.private_subnets_ids)

  id = each.key
  depends_on = [
    module.vpc
  ]
}

locals {
  public_az       = {
    for s in data.aws_subnet.public : s.availability_zone => s.id
  }
  private_az       = {
    for s in data.aws_subnet.private : s.availability_zone => s.id
  }
}

module "ec2-bastion" {
  source = "../../modules/ec2"
  name   = "bastion-01"
  region = "us-east-1"
  ami    = {
      us-east-1 = "ami-0ab4d1e9cf9a1215a"
  }

  enable_instance             = true
  environment                 = "learning"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  root_block_device           = [{
      delete_on_termination = true
      volume_size           = 20
      volume_type           = "gp2"
  }]

  disk_size                             = null
  tenancy                               = "default"
  subnet_id                             = lookup(local.public_az, "us-east-1c")
  vpc_security_group_ids                = [module.bastion-sg.security_group_id]
  user_data                             = file("additional_files/bastion.yaml")
  instance_initiated_shutdown_behavior  = "terminate"

  tags = tomap({
    "Environment"   = "learning",
    "stack" =  "ebs"
    "Owner"     = "Andrei Leodorov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.vpc,
    module.bastion-sg
  ]
}

module "ec2-private-1" {
  source = "../../modules/ec2"
  name   = "private-host1"
  region = "us-east-1"
  ami    = {
      us-east-1 = "ami-0ab4d1e9cf9a1215a"
  }

  enable_instance                       = true
  environment                           = "learning"
  instance_type                         = "t2.micro"
  root_block_device                     = [{
      delete_on_termination = true
      volume_size           = 20
      volume_type           = "gp2"
  }]
  tenancy                               = "default"
  subnet_id                             = lookup(local.private_az, "us-east-1b")
  vpc_security_group_ids                = [module.priv-sg.security_group_id]
  user_data                             = file("additional_files/private-host.yaml")
  instance_initiated_shutdown_behavior  = "terminate"

  tags = tomap({
    "Environment"   = "learning",
    "stack" =  "ebs"
    "Owner"     = "Andrei Leodorov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.vpc,
    module.priv-sg
  ]
}

module "ec2-private-2" {
  source = "../../modules/ec2"
  name   = "private-host2"
  region = "us-east-1"
  ami    = {
      us-east-1 = "ami-0ab4d1e9cf9a1215a"
  }

  enable_instance                       = true
  environment                           = "learning"
  instance_type                         = "t2.micro"
  root_block_device                     = [{
      delete_on_termination = true
      volume_size           = 20
      volume_type           = "gp2"
  }]
  tenancy                               = "default"
  subnet_id                             = lookup(local.private_az, "us-east-1b")
  vpc_security_group_ids                = [module.priv-sg.security_group_id]
  user_data                             = file("additional_files/private-host.yaml")
  instance_initiated_shutdown_behavior  = "terminate"

  tags = tomap({
    "Environment"   = "learning",
    "stack" =  "ebs"
    "Owner"     = "Andrei Leodorov",
    "Orchestration" = "Terraform"
  })

  depends_on = [
    module.vpc,
    module.priv-sg
  ]
}