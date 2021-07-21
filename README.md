# 05 EC2 + EBS

The task to create an EBS volume and check ability to mount this volume to another EC2 instance and check that data in this EBS attached volume can be read.

## Used resources

terraform modules from https://github.com/SebastianUA/terraform.git

Great thanks to Vitaliy Natarov!

## AWS CREDENTIALS

```
aws configure
```

## Terrfaorm

```
terraform init
terrafrom plan
terraform apply -target module.vpc #that is needed to get id of subnets and use it in ec2 playbook
terrafrom apply
terraform destroy
```