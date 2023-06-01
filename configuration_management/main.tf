data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "appsilon_keypair" {
  key_name   = "eddie's macbook"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_security_group" "appsilon_security_group" {
  name        = "appsilon-security-group"
  description = "Allow SSH access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "appsilon_ec2" {
  ami           = data.aws_ami.ubuntu.id # Ubuntu 22 Linux x86
  instance_type = "t2.micro"

  key_name        = aws_key_pair.appsilon_keypair.key_name
  vpc_security_group_ids = [aws_security_group.appsilon_security_group.id]

  provisioner "local-exec" {
    command = "sleep 60" # Wait for the instance to start before executing Ansible
  }
}

output "instance_ip" {
  value = aws_instance.appsilon_ec2.public_ip
}
