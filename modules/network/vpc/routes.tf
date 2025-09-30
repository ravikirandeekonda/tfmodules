resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.project}-${var.environment}-public-rtb"
  }
}

resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.project}-${var.environment}-private-rtb"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${local.project}-${var.environment}-igw"
  }
}

resource "aws_route" "rtb" {
  route_table_id = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
    depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table_association" "public_rtb_assoc" {
  count = length(var.public_subnets_cidr)
  subnet_id = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "private_rtb_assoc" {
  count = length(var.private_subnets_cidr)
  subnet_id = element(aws_subnet.private_subnets_cidr.*.id, count.index)
  route_table_id = aws_route_table.private_rtb.id
}