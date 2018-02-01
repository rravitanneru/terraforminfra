resource "aws_instance" "bastion" {                                    
  ami           = "ami-531a4c3c"
  instance_type = "t2.micro"
  key_name  = "ravi"
  private_ip = "10.0.0.13"
  subnet_id  = "${aws_subnet.public.id}"

   security_groups = [
    "${aws_security_group.bastion.id}"
  ]
tags {
Name = "Bastion Instance"

}
 
}

resource "aws_eip" "basip" {                                      # Eip for Bastion
  vpc = true

  instance                  = "${aws_instance.bastion.id}"
  associate_with_private_ip = "10.0.0.13"
  depends_on                = ["aws_internet_gateway.default"]
}



