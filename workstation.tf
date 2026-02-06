module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "workstation-eksctl"
  ami = data.aws_ami.centos8.id
  instance_type          = "t3.micro"
#   key_name               = "user1"
#   monitoring             = true
  vpc_security_group_ids = [aws_security_group.allow_eksctl.id]
  subnet_id              = "subnet-0929e189892e88609"
  user_data = file("workstation.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "allow_eksctl" {
  name        = "allow_eksctl"
  description = "created for eksctl"
#   vpc_id      = aws_vpc.main.id #default vpc

  tags = {
    Name = "allow_eksctl"
  }
  ingress {
    description = "allow all ports"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

data "aws_ami" "centos8" {
  owners           = ["973714476881"]
  most_recent      = true

    filter {
    name   = "name"
    values = ["Redhat-9-DevOps-Practice"]
  }
    filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
   filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}