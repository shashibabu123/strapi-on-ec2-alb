resource "aws_instance" "strapi" {
  ami           = "ami-084568db4383264d4" 
  instance_type = "t3.small"
  key_name      = var.key_name
  subnet_id     = var.public_subnet_id
  security_groups = [aws_security_group.strapi_ec2_sg.id]

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "StrapiEC2"
  }
}

