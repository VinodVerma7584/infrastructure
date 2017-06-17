// my key pair
variable "keypair" {
  default = "outsider-aws"
}

// availability zones
data "aws_availability_zones" "available" {}

// latest ubuntu ami
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}
