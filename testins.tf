resource "aws_instance" "test" {                                    # NAT instance
  ami           = "ami-531a4c3c"
  instance_type = "t2.micro"
  key_name  = "ravi"
  subnet_id  = "${aws_subnet.private.id}"

   security_groups = [
    "${aws_security_group.private.id}"
  ]
tags {
Name = "Test instance"

}

}

