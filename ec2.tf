data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_key_pair" "phase1" {
  key_name   = "phase1-key"
  public_key = file("~/.ssh/phase1-key.pub")

  tags = {
    Name      = "phase1-key"
    ManagedBy = "terraform"
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.public.id]
  key_name                    = aws_key_pair.phase1.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello depuis Terraform - Phase 1 !</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Name      = "ec2-phase1-web"
    ManagedBy = "terraform"
  }
}   