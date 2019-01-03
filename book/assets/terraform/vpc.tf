resource "aws_vpc" "reader" {
  cidr_block           = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "reader-vpc"
  }
}

resource "aws_subnet" "reader-1a" {
  vpc_id            = "${aws_vpc.reader.id}"
  cidr_block        = "${var.subnet_1a_cidr}"
  availability_zone = "${var.subnet_1a_az}"

  tags {
    Name = "reader-1a"
  }
}

resource "aws_internet_gateway" "reader-igw" {
  vpc_id = "${aws_vpc.reader.id}"

  tags {
    Name = "reader-igw"
  }
}

resource "aws_route_table" "reader-1a-rt" {
  vpc_id = "${aws_vpc.reader.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.reader-igw.id}"
  }

  tags {
    Name = "reader-1a-rt"
  }
}

resource "aws_route_table_association" "reader-1a-rta" {
  subnet_id      = "${aws_subnet.reader-1a.id}"
  route_table_id = "${aws_route_table.reader-1a-rt.id}"
}
