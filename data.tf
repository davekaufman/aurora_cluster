# data "aws_caller_identity" "current" {}

data "aws_vpc" "default" {
  tags   = {
    Name = "${var.vpc_name}"
  }
}

data "aws_subnet" "backend" {
  vpc_id = "${data.aws_vpc.default.id}"

  tags   = {
    Name = "${var.backend_subnet_name}"
  }
}

data "aws_subnet_ids" "db" {
  vpc_id = "${data.aws_vpc.default.id}"

  tags   = {
    Name = "${var.db_subnet_name}"
  }
}

data "aws_subnet" "db" {
  count = "${length(data.aws_subnet_ids.db.ids)}"
  id = "${data.aws_subnet_ids.db.ids[count.index]}"
}

data "aws_route53_zone" "prod" {
  name   = "${var.dns_zone_name}."
  private_zone = true
}
