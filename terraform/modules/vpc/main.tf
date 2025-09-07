resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "notes-vpc" }
}

resource "aws_subnet" "public" {
  count = 2
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = { Name = "public-${count.index}" }
}

resource "aws_subnet" "private" {
  count = 2
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(aws_vpc.this.cidr_block, 8, count.index + 10)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = { Name = "private-${count.index}" }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_security_group" "lambda_sg" {
  vpc_id = aws_vpc.this.id
  name   = "lambda-sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_availability_zones" "available" {}

output "vpc_id" {
  value = aws_vpc.this.id
}
output "public_subnets" {
  value = aws_subnet.public[*].id
}
output "private_subnets" {
  value = aws_subnet.private[*].id
}
output "lambda_sg_id" {
  value = aws_security_group.lambda_sg.id
}

