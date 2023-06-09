#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "final" {
  cidr_block = "10.0.0.0/16"

  tags = tomap({
    "Name"                                      = "terraform-eks-final-node",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  })
}

resource "aws_subnet" "final" {
  count = 2

  availability_zone       = data.aws_availability_zones.available.names[count.index]
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.final.id

  tags = tomap({
    "Name"                                      = "terraform-eks-final-node",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  })
}

resource "aws_internet_gateway" "final" {
  vpc_id = aws_vpc.final.id

  tags = {
    Name = "terraform-eks-final"
  }
}

resource "aws_route_table" "final" {
  vpc_id = aws_vpc.final.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.final.id
  }
}

resource "aws_route_table_association" "final" {
  count = 2

  subnet_id      = aws_subnet.final[count.index].id
  route_table_id = aws_route_table.final.id
}