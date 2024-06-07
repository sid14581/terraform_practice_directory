
resource "aws_subnet" "sid_public_subnet" {
  vpc_id            = aws_vpc.sid_vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "sid_private_subnet" {
  vpc_id            = aws_vpc.sid_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1f"

  tags = {
    Name = "Private Subnet"
  }
}