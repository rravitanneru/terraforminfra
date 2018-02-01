resource "aws_vpc" "default"{                             # VPC 
cidr_block = "10.0.0.0/16"
enable_dns_support = "true"
enable_dns_hostnames = "true"

 tags {
    Environment = "test"
    Group = "inf"
    Name = "test"
    
  }

}


resource "aws_internet_gateway" "default" {              # IGW for VPC
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Environment = "test"
    Group = "inf"
    Name = "test"
    
  }
}



