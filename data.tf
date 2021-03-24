data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  tags   = {
    Name = "Default"
  }
}

data "aws_subnet" "backend" {
  vpc_id = "${data.aws_vpc.default.id}"

  tags   = {
    Name = "backend"
  }
}

data "aws_subnet" "db" {
  vpc_id = "${data.aws_vpc.default.id}"

  tags   = {
    Name = "databases"
  }
}

data "aws_route53_zone" "prod" {
  name   = "${var.dns_zone_name}."
  private_zone = true
}
