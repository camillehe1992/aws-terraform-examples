# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/vpc
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  tags       = merge({ Name = "${var.env}-${var.nickname}" }, var.tags)
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge({ Name = "${var.env}-${var.nickname}" }, var.tags)
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/subnet
resource "aws_subnet" "private" {
  for_each = local.private_subnet_cidrs

  availability_zone = data.aws_availability_zones.available.names[each.key]
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value

  tags = merge({ Name = "${var.env}-${var.nickname}-private-${each.key}" }, var.tags)
}

resource "aws_subnet" "public" {
  for_each = local.public_subnet_cidrs

  availability_zone = data.aws_availability_zones.available.names[each.key]
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value

  tags = merge({ Name = "${var.env}-${var.nickname}-public-${each.key}" }, var.tags)
}

resource "aws_eip" "this" {
  for_each = local.public_subnet_cidrs

  domain = "vpc"

  tags = merge({ Name = "${var.env}-${var.nickname}-eip-${each.key}-${each.value}" }, var.tags)
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/nat_gateway
resource "aws_nat_gateway" "this" {
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.this]

  count = length(aws_subnet.public)

  allocation_id = aws_eip.this[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge({ Name = "${var.env}-${var.nickname}-nat-gateway-${count.index}" }, var.tags)
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/route_table
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge({ Name = "${var.env}-${var.nickname}-rtb" }, var.tags)
}
# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/route_table_association
resource "aws_route_table_association" "igw-rule" {
  depends_on = [aws_vpc.this, aws_subnet.public]
  for_each   = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.this.id
}

# https://registry.terraform.io/providers/hashicorp/aws/5.0.0/docs/resources/security_group
resource "aws_security_group" "elb" {
  depends_on = [aws_vpc.this]

  name        = "${var.env}-${var.nickname}-elb"
  description = "Security group for load balancer layer"
  vpc_id      = aws_vpc.this.id

  ingress {
    description = "Allow HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  ingress {
    description = "Allow HTTPS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.this.cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge({ Name = "${var.env}-${var.nickname}-elb" }, var.tags)
}

resource "aws_security_group" "app" {
  depends_on = [aws_vpc.this, aws_security_group.elb]

  name        = "${var.env}-${var.nickname}-app"
  description = "Security group for application layer"
  vpc_id      = aws_vpc.this.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge({ Name = "${var.env}-${var.nickname}-app" }, var.tags)
}

resource "aws_security_group_rule" "app-ingress" {
  depends_on = [aws_security_group.elb]

  description              = "Allow ingress traffic from ${aws_security_group.elb.id}"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.app.id
  source_security_group_id = aws_security_group.elb.id
}

resource "aws_security_group" "data" {
  depends_on = [aws_vpc.this, aws_security_group.app]

  name        = "${var.env}-${var.nickname}-data"
  description = "Security group for database layer"
  vpc_id      = aws_vpc.this.id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge({ Name = "${var.env}-${var.nickname}-data" }, var.tags)
}

resource "aws_security_group_rule" "data-ingress" {
  depends_on = [aws_security_group.app]

  description              = "Allow ingress traffic from ${aws_security_group.app.id}"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.data.id
  source_security_group_id = aws_security_group.app.id
}
