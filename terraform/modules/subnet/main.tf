#2)create subnet
resource "aws_subnet" "ownsubnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr_block
availability_zone=var.az

  tags = {
    Name = "${var.env}-subnet"
  }
}

#3) create igw
resource "aws_internet_gateway" "ownigw"{
  vpc_id = var.vpc_id
    tags = {
    Name = "${var.env}-igw"
  }

}

#4) route table
resource "aws_route_table" "ownrt"{
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ownigw.id
  }
  tags={
    Name: "${var.env}-rt"
  }
}

#5)associate rt to subnet

resource "aws_route_table_association" "a"{
  subnet_id = aws_subnet.ownsubnet.id
  route_table_id = aws_route_table.ownrt.id
}
