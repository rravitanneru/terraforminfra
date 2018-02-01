resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.default.id}"                         #Public subnet declaration
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = "true"
  tags {
    Name = "public subnet"
  }
}


resource "aws_route_table" "igw" {                             #Route table for public subnet
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }
}

resource "aws_route_table_association" "igw" {                 #Route table association with public subnet
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.igw.id}"
}



resource "aws_subnet" "private" {                              #Private subnet declaration

vpc_id    = "${aws_vpc.default.id}"
cidr_block = "10.0.1.0/24"
tags

{
Name = "private subnet"
}

}

resource "aws_default_route_table" "default" {
  default_route_table_id = "${aws_vpc.default.default_route_table_id}"

route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }

    
  

  tags {
    Name = "default table"
  }
}

/*
resource "aws_route_table" "nat" {                             #Declaring NAT for private subnet
vpc_id   = "${aws_vpc.default.id}"

route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }

}

*/


resource "aws_route_table_association" "nat" {                #Route table association for the private subnet
  subnet_id      = "${aws_subnet.private.id}"
  route_table_id = "${aws_default_route_table.default.id}"
}


