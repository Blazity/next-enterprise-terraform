resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support   = true
    enable_dns_hostnames = true

    tags = {
        Name = "Default VPC for ${var.project_name}"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "Internet gateway for ${var.project_name}"
    }
}

resource "aws_subnet" "public_subnet_a" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.0.0.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "eu-west-2a"
    tags = {
        Name = "Subnet A public for ${var.project_name}"
    }
}

resource "aws_subnet" "public_subnet_b" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "eu-west-2b"
    tags = {
        Name = "Subnet B public for ${var.project_name}"
    }
}

resource "aws_subnet" "public_subnet_c" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "eu-west-2c"
    tags = {
        Name = "Subnet C public for ${var.project_name}"
    }
}

resource "aws_subnet" "private_subnet_a" {
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = "10.0.10.0/24"
    availability_zone = "eu-west-2a"
    tags = {
        Name = "Subnet A private for ${var.project_name}"
    }
}

resource "aws_subnet" "private_subnet_b" {
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = "10.0.11.0/24"
    availability_zone = "eu-west-2b"
    tags = {
        Name = "Subnet B private for ${var.project_name}"
    }
}

resource "aws_subnet" "private_subnet_c" {
    vpc_id            = aws_vpc.vpc.id
    cidr_block        = "10.0.12.0/24"
    availability_zone = "eu-west-2c"
    tags = {
        Name = "Subnet C private for ${var.project_name}"
    }
}

resource "aws_eip" "nat_eip" {
    domain = "vpc"
    tags = {
        Name = "Natgateway for ${var.project_name}"
    }
}

resource "aws_nat_gateway" "nat_gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id     = aws_subnet.public_subnet_a.id
}

# Public Route Table
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "Route public for ${var.project_name}"
    }
}

resource "aws_route" "public_internet_access" {
    route_table_id         = aws_route_table.public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc_a" {
    subnet_id      = aws_subnet.public_subnet_a.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_b" {
    subnet_id      = aws_subnet.public_subnet_b.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc_c" {
    subnet_id      = aws_subnet.public_subnet_c.id
    route_table_id = aws_route_table.public_rt.id
}

# Private Route Table (Uses NAT Gateway)
resource "aws_route_table" "private_nat_route" {
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "Route private for ${var.project_name}"
    }
}

resource "aws_route" "private_nat_access" {
    route_table_id         = aws_route_table.private_nat_route.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = aws_nat_gateway.nat_gw.id
}

resource "aws_route_table_association" "private_assoc_a" {
    subnet_id      = aws_subnet.private_subnet_a.id
    route_table_id = aws_route_table.private_nat_route.id
}

resource "aws_route_table_association" "private_assoc_b" {
    subnet_id      = aws_subnet.private_subnet_b.id
    route_table_id = aws_route_table.private_nat_route.id
}

resource "aws_route_table_association" "private_assoc_c" {
    subnet_id      = aws_subnet.private_subnet_c.id
    route_table_id = aws_route_table.private_nat_route.id
}
