resource "aws_ebs_volume" "test" {
  availability_zone = "us-east-1b"
  size              = 10
  type              = "gp2"

  tags = tomap({
    "Environment"   = "learning",
    "stack" =  "ebs"
    "Owner"     = "Andrei Leodorov",
    "Orchestration" = "Terraform"
  })
}