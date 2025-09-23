resource "aws_subnet" "public_subnets" {
  cidr_block              = var.public_subnets_cidr
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  depends_on              = [aws_vpc.vpc]
  tags = {
    Name = "demo-public-subnet"
  }
}
