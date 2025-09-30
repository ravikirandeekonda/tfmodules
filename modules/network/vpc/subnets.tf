resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnets_cidr)
  cidr_block              = element(var.public_subnets_cidr, count.index)
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  depends_on              = [aws_vpc.vpc]
  tags = {
    Name = "${local.project}-${var.environment}-public-subnet-${element(var.availability_zones, count.index)}"
  }
}

resource "aws_subnet" "private_subnets_cidr" {
  count             = length(var.private_subnets_cidr)
  cidr_block        = element(var.private_subnets_cidr, count.index)
  vpc_id            = aws_vpc.vpc.id
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  depends_on        = [aws_vpc.vpc]
  tags = {
    Name = "${local.project}-${var.environment}-private-subnet-${element(var.availability_zones, count.index)}"
  }
}
