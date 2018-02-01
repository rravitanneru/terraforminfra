resource "aws_security_group" "nat" {
  name = "NAT"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]

  }

ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]

  }

ingress {
    from_port   = 1
    to_port     = 1
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"]

  }
ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }



  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "NATsg"
  }
}


resource "aws_security_group" "bastion" {
  name = "bastion"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }


ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    self = true
    cidr_blocks = ["10.0.1.0/24"]
  }


  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "bastionsg"
  }
}

resource "aws_security_group" "private" {
  name = "private"
  vpc_id = "${aws_vpc.default.id}"

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    security_groups = [
      "${aws_security_group.bastion.id}"
    ]
  }
 egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "private"
  }
}

