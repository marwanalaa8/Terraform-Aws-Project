data "aws_ami" "al2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Public EC2 (Bastion)
resource "aws_instance" "public" {
  ami                         = data.aws_ami.al2.id
  instance_type               = var.instance_type_public
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.bastion_sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = true
  user_data                   = <<-EOF
            #!/bin/bash
            yum update -y
            yum install -y httpd
            systemctl enable httpd
            systemctl start httpd
            echo "Hello from PUBLIC EC2" > /var/www/html/index.html
            EOF

  tags = merge(var.tags, {
    Name = "${var.project_name}-public-ec2"
    Tier = "public"

  })
}

# Private EC2 (Apache)
resource "aws_instance" "private" {
  ami                         = data.aws_ami.al2.id
  instance_type               = var.instance_type_private
  subnet_id                   = var.private_subnet_id
  vpc_security_group_ids      = [var.private_sg_id]
  key_name                    = var.key_name
  associate_public_ip_address = false

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl enable httpd
              systemctl start httpd
              echo "Hello from PRIVATE Apache EC2" > /var/www/html/index.html
              EOF

  tags = merge(var.tags, {
    Name = "${var.project_name}-private-apache-ec2"
    Tier = "private"
  })
}
