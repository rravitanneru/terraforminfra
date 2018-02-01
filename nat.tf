resource "aws_instance" "nat" {                                    # NAT instance
  ami           = "ami-e32a408c"
  instance_type = "t2.micro"
  key_name  = "ravi"
  private_ip = "10.0.0.12"
  subnet_id  = "${aws_subnet.public.id}"
  source_dest_check = "false"

   security_groups = [
    "${aws_security_group.nat.id}"
  ]
tags {
Name = "NAT Instance"

}
 
}

resource "aws_eip" "natip" {                                      # Eip for NAT
  vpc = true

  instance                  = "${aws_instance.nat.id}"
  associate_with_private_ip = "10.0.0.12"
  depends_on                = ["aws_internet_gateway.default"]
}


