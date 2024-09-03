provider "aws" {
  region     = "ap-south-1"

}
resource "aws_vpc" "sample_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name       = "sample_vpc"
    created_by = "rohit"
    terraform  = "true"
  }

}
resource "aws_subnet" "public_sample_subnet" {
  vpc_id     = aws_vpc.sample_vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name       = "public-sample_vpc"
    created_by = "rohit"
    terraform  = "true"
  }
}
resource "aws_subnet" "private_sample_subnet" {
  vpc_id     = aws_vpc.sample_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "privet-sample_subnet"
  }
}
resource "aws_internet_gateway" "sample_ig" {
  vpc_id = aws_vpc.sample_vpc.id
  tags = {
    Name = "sample-IG"
  }
}
resource "aws_route_table" "sample_route" {
  vpc_id = aws_vpc.sample_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.sample_ig.id
  }
  tags = {
    Name = "sample-route"

  }

}
resource "aws_route_table_association" "sample_rp" {
  subnet_id      = aws_subnet.public_sample_subnet.id
  route_table_id = aws_route_table.sample_route.id

}