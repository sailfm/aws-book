resource "aws_instance" "reader-1" {
  ami           = "${var.aws_ami}"
  instance_type = "${var.instance_type}"

  tags {
    Name = "reader1"
  }
}

resource "aws_security_group" "reader-1-sg" {
  name        = "reader-1-sg"
  description = "reader-1-sg"
  vpc_id      = "${aws_vpc.reader.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "reader-1-sg"
  }
}

resource "aws_eip" "reader-1-eip" {
  instance = "${aws_instance.reader-1.id}"
  vpc      = true
}
