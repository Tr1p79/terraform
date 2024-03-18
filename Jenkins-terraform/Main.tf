#VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs            = data.aws_availability_zones.azs.names
  public_subnets = var.public_subnets
  map_public_ip_on_launch = true

  enable_dns_hostnames = true

  tags = {
    Name        = "jenkins-vpc"
    Terraform   = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    Name = "jenkins-subnet"
  }
}

#SG
module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-sg"
  description = "Security group for Jenkins Server"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    for port in [22, 80, 443, 8080, 9000, 3000] :
    {
      from_port   = port
      to_port     = port
      protocol    = "tcp"
      description = "TLS from VPC"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  tags = {
    Name = "jenkins-sg"
  }
}
#EC2
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "Jenkins-Argo-Server"

  ami                         = "ami-06aa3f7caf3a30282"
  instance_type               = var.instance_type
  key_name                    = "Terra-Jen"
  monitoring                  = true
  vpc_security_group_ids      = [module.sg.security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  user_data                   = templatefile("./install_jenkins.sh", {})
  availability_zone           = data.aws_availability_zones.azs.names[0]

  tags = {
    Name        = "Jenkins-Argo"
    Terraform   = "true"
    Environment = "dev"
  }
}