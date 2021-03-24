module "rds" {
  source               = "./modules/rds/"
  vpc_id               = "${data.aws_vpc.default.id}"
  db_name              = "${var.db_name}"
  db_subnets           = ["${data.aws_subnet.db.*.id}"]

  cluster_size         = "${var.cluster_size}"
  instance_type        = "${var.instance_type}"
  db_pass              = "${var.db_pass}"

  dns_zone_id          = "${data.aws_route53_zone.prod.zone_id}"
  dns_zone_name        = "${data.aws_route53_zone.prod.name}"

  # sg rules
  jumpbox_cidr         = "${var.jumpbox_cidr}"
  cidr_rules           = "${var.cidr_rules}"
  sgid_rules           = "${var.sgid_rules}"
  backend_subnet_cidrs = ["${data.aws_subnet.backend.cidr_block}"]


  tags                 = "${var.tags}"
}
