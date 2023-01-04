resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
    vpc_id = "${aws_vpc.dev.id}"

  dynamic "ingress" {
    for_each = [22, 80, 443, 3306, 27017]
    iterator = sum
    content {
      description      = "TLS from VPC"
      from_port        = sum.value
      to_port          = sum.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}
