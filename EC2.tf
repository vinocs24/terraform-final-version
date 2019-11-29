# Create EC2 instance
resource "aws_instance" "webservers" {
	count = length(var.subnets_cidr)
	ami = var.webservers_ami
	instance_type = var.instance_type
	security_groups = [aws_security_group.webservers.id]
	subnet_id = element(aws_subnet.public.*.id,count.index)
	user_data = file("install_httpd.sh")

	tags = {
	  Name = "Server-count.index"
	}
}

resource "aws_security_group" "webservers" {
  name        = "allow_http"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.terra_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
