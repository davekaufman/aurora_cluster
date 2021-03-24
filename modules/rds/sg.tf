resource "aws_security_group" "cluster" {
  name                     = "rds"
  description              = "RDS Security Group"
  vpc_id                   = "${var.vpc_id}"
  tags                     = "${merge(var.tags, map("Name", "rds"))}"

}

resource "aws_security_group_rule" "self" {
  type                     = "ingress"
  description              = "self"
  from_port                = "${var.db_port}"
  to_port                  = "${var.db_port}"
  protocol                 = "tcp"
  self                     = true
  security_group_id        = "${aws_security_group.cluster.id}"
}

resource "aws_security_group_rule" "backend" {
  type                     = "ingress"
  description              = "access to ${var.db_port} from backend subnets"
  from_port                = "${var.db_port}"
  to_port                  = "${var.db_port}"
  protocol                 = "tcp"
  cidr_blocks              = ["${var.backend_subnet_cidrs}"]
  security_group_id        = "${aws_security_group.cluster.id}"
}

resource "aws_security_group_rule" "bastion" {
  type                     = "ingress"
  description              = "access to ${var.db_port} from bastion host"
  from_port                = "${var.db_port}"
  to_port                  = "${var.db_port}"
  protocol                 = "tcp"
  cidr_blocks              = ["${var.jumpbox_cidr}"]
  security_group_id        = "${aws_security_group.cluster.id}"
}

resource "aws_security_group_rule" "cidr_rules" {
  count                    = "${length(var.cidr_rules)}"

  type                     = "ingress"
  from_port                = "${lookup(var.cidr_rules[count.index], "from_port", "${var.db_port}")}"
  to_port                  = "${lookup(var.cidr_rules[count.index], "to_port", "${var.db_port}")}"
  protocol                 = "${lookup(var.cidr_rules[count.index], "protocol", "tcp")}"
  description              = "${lookup(var.cidr_rules[count.index], "description", "empty")}"
  cidr_blocks              = ["${split(",", lookup(var.cidr_rules[count.index], "cidr"))}"]
  security_group_id        = "${aws_security_group.cluster.id}"
}

resource "aws_security_group_rule" "sgid_rules" {
  count                    = "${length(var.sgid_rules)}"

  type                     = "ingress"
  from_port                = "${lookup(var.sgid_rules[count.index], "from_port", "${var.db_port}")}"
  to_port                  = "${lookup(var.sgid_rules[count.index], "to_port", "${var.db_port}")}"
  protocol                 = "${lookup(var.sgid_rules[count.index], "protocol", "tcp")}"
  description              = "${lookup(var.sgid_rules[count.index], "description", "empty")}"
  source_security_group_id = "${lookup(var.sgid_rules[count.index], "source_security_group_id")}"
  security_group_id        = "${aws_security_group.cluster.id}"
}

resource "aws_security_group_rule" "outbound" {
  type                     = "egress"
  description              = "allow all outbound"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  cidr_blocks              = ["0.0.0.0/0"]
  security_group_id        = "${aws_security_group.cluster.id}"
}
