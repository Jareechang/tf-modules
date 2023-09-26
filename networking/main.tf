locals {
    # Mainly used to determine how many nat gateway, eni, route table and rt association we need for private subnets
    nat_gw_count = length(var.subnet_private_cidrblock) > 2 ? length(var.subnet_private_cidrblock) : 1
}

#### VPC
resource "aws_vpc" "main" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
        Name = "${var.project_id}-${var.env}-web"
    }
}

#### Public subnets - internet facing  (lb, gateways)
resource "aws_subnet" "public_subnets" {
    # Minimum of two
    count      = min(length(var.azs), length(var.subnet_public_cidrblock))
    vpc_id     = aws_vpc.main.id
    cidr_block = var.subnet_public_cidrblock[count.index]
    availability_zone = var.azs[count.index]
    tags = {
        Name = "subnet-public-${var.azs[count.index]}"
    }
}

#### Private subnets - Internal facing (apps, db etc)
resource "aws_subnet" "private_subnets" {
    count      = min(length(var.azs), length(var.subnet_private_cidrblock))
    vpc_id     = aws_vpc.main.id
    cidr_block = var.subnet_private_cidrblock[count.index]
    availability_zone = var.azs[count.index]
    tags = {
        Name = "subnet-private-${var.azs[count.index]}"
    }
}


### Internet Gateway
resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "igw-public"
    }
}

resource "aws_eip" "nat_eip" {
    count    = local.nat_gw_count
    vpc      = true
}

### NAT Gateway - Only use one nat gateway for 2 subnets (stage environments)
resource "aws_nat_gateway" "nat_public" {
    count         = local.nat_gw_count
    allocation_id = aws_eip.nat_eip[count.index].id
    subnet_id     = aws_subnet.public_subnets[count.index].id
    tags = {
        Name = "nat-gateway-${var.azs[count.index]}"
    }
    depends_on = [aws_internet_gateway.main]
}

### Route Tables
resource "aws_route_table" "rt_public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main.id
    }
    route {
        ipv6_cidr_block        = "::/0"
        gateway_id = aws_internet_gateway.main.id
    }
    tags = {
        Name = "rt-public"
    }
}

resource "aws_route_table" "rt_private" {
    count          = local.nat_gw_count
    vpc_id         = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = (
            local.nat_gw_count > 2
            ? aws_nat_gateway.nat_public[count.index].id
            : aws_nat_gateway.nat_public[0].id
        )
    }
    tags = {
        Name = "rt-private-${var.azs[count.index]}"
    }
}

resource "aws_route_table_association" "public_rt_associations" {
    count          = length(aws_subnet.public_subnets)
    subnet_id      = aws_subnet.public_subnets[count.index].id
    route_table_id = aws_route_table.rt_public.id
}

resource "aws_route_table_association" "private_rt_associations" {
    count          = length(aws_subnet.private_subnets)
    subnet_id      = aws_subnet.private_subnets[count.index].id
    route_table_id = (
        local.nat_gw_count > 2
        ? aws_route_table.rt_private[count.index].id
        : aws_route_table.rt_private[0].id
    )
}

### Network ACL
resource "aws_network_acl" "nacl_public" {
    vpc_id     = aws_vpc.main.id
    subnet_ids = aws_subnet.public_subnets[*].id
    ingress {
        protocol   = -1
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    egress {
        protocol   = -1
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 0
        to_port    = 0
    }

    tags = {
        Name = "nacl-public"
    }
}

resource "aws_network_acl" "nacl_private" {
    vpc_id = aws_vpc.main.id
    subnet_ids = aws_subnet.private_subnets[*].id

    ## In-coming
    ingress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 22
        to_port    = 22
    }
    ingress {
        protocol   = "tcp"
        rule_no    = 200
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 80
        to_port    = 80
    }
    ingress {
        protocol   = "tcp"
        rule_no    = 300
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 443
        to_port    = 443
    }
    ingress {
        protocol   = "tcp"
        rule_no    = 400
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 1024
        to_port    = 65535
    }

    ## out-going
    egress {
        protocol   = "tcp"
        rule_no    = 100
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 22
        to_port    = 22
    }
    egress {
        protocol   = "tcp"
        rule_no    = 200
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 80
        to_port    = 80
    }
    egress {
        protocol   = "tcp"
        rule_no    = 300
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 443
        to_port    = 443
    }
    egress {
        protocol   = "tcp"
        rule_no    = 400
        action     = "allow"
        cidr_block = "0.0.0.0/0"
        from_port  = 1024
        to_port    = 65535
    }

    tags = {
        Name = "nacl-private"
    }
}
