#----------------------------
#1. Create custom vpc
#----------------------------

resource "aws_vpc" "production_environment" {
  cidr_block = "10.0.0.0/16"
}

#----------------------------
#2. Create Internet gateway
#----------------------------

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.production_environment.id

}

#----------------------------
#3. Create custom route table
#----------------------------

resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.production_environment.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "prod"
  }
}

#-------------------
#4. Create subnet
#-------------------

resource "aws_subnet" "subnet-1" {
     vpc_id = aws_vpc.production_environment.id
     cidr_block = "10.0.1.0/24"
     availability_zone ="us-east-1a"
     map_public_ip_on_launch = true

     tags = {
      Name = "prod_subnet1"
     }
}

resource "aws_subnet" "subnet-2" {
     vpc_id = aws_vpc.production_environment.id
     cidr_block = "10.0.2.0/24"
     availability_zone ="us-east-1b"
     map_public_ip_on_launch = false
     tags = {
      Name = "prod_subnet2"
     }
}

#------------------------------------
#5. Associate subnet with route table
#------------------------------------

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.prod-route-table.id
}