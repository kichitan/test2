# create vpc
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name       = "${var.project_name}-${var.env}-vpc"
    Enviroment = "${var.project_name}-${var.env}"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name       = "${var.project_name}-${var.env}-igw"
    Enviroment = "${var.project_name}-${var.env}"
  }
}

# Get all avalablility zones
data "aws_availability_zones" "azs" {}

# create public subnet bastion
resource "aws_subnet" "bastion" {
  count = 1
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.azs.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name       = "${var.project_name}-${var.env}-bastion-net"
    Enviroment = "${var.project_name}-${var.env}"
  }
}

# create public subnets for alb in 3 azs
resource "aws_subnet" "lbs" {
  count      = length(var.azs)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index+16)
  availability_zone       = element(var.azs, count.index)
#  vpc_id                  = aws_vpc.vpc.id
#  cidr_block              = var.lb01_net_az1_cidr
#  availability_zone       = data.aws_availability_zones.azs.names[0]
 map_public_ip_on_launch = false

  tags = {
    Name       = "${var.project_name}-${var.env}-lb0${count.index+1}-net-${element(var.azs, count.index)}"
    Enviroment = "${var.project_name}-${var.env}"
  }
}

# create route table and add public route
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name       = "${var.project_name}-${var.env}-public-rt"
    Enviroment = "${var.project_name}-${var.env}"
  }
}

# associate public subnet bastion to public route table"
resource "aws_route_table_association" "bastion-net-assoc" {
  subnet_id      = aws_subnet.bastion[0].id
  route_table_id = aws_route_table.pub_rt.id
}

# associate public subnet albs to "public route table"
resource "aws_route_table_association" "alb" {
  count          = length(var.azs)
  subnet_id      = element(aws_subnet.lbs.*.id, count.index)
  route_table_id = aws_route_table.pub_rt.id
}


# create private subnet for lrs in 3 azs
resource "aws_subnet" "lrs" {
  count      = length(var.azs)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index+48)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name       = "${var.project_name}-${var.env}-lrs0${count.index+1}-net-${element(var.azs, count.index)}"
    Enviroment = "${var.project_name}-${var.env}"
  }
}


# create private subnet for dbs in 3 azs
resource "aws_subnet" "dbs" {
  count      = length(var.azs)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index+64)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name       = "${var.project_name}-${var.env}-dbs0${count.index+1}-net-${element(var.azs, count.index)}"
    Enviroment = "${var.project_name}-${var.env}"
  }
}

# create private subnet for efs in 3 azs
resource "aws_subnet" "efs" {
  count      = length(var.azs)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index+80)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name       = "${var.project_name}-${var.env}-efs0${count.index+1}-net-${element(var.azs, count.index)}"
    Enviroment = "${var.project_name}-${var.env}"
  }
}
