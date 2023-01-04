
resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id = "${aws_subnet.dev_public-1.id}"
  key_name               = aws_key_pair.key-tf.key_name
   user_data = <<-EOF
  #!/bin/bash -ex

  amazon-linux-extras install nginx1 -y
  echo "<h1>$(curl https://api.kanye.rest/?format=text)</h1>" >  /usr/share/nginx/html/index.html 
  systemctl enable nginx
  systemctl start nginx
  EOF
  tags = {
    Name = "Demo_Project"
  }
}
