resource "aws_db_subnet_group" "cluster" {
  name                       = "${var.db_name}-cluster-subnets"
  description                = "${var.db_name} RDS subnet group"
  subnet_ids                 = ["${var.db_subnets}"]
  tags                       = "${merge(var.tags, map("Name", "${var.db_name}-cluster-subnets"))}"
}

resource "aws_rds_cluster_instance" "cluster" {
  count                      = "${var.cluster_size}"

  identifier                 = "${var.db_name}-${count.index}"
  cluster_identifier         = "${aws_rds_cluster.cluster.id}"
  instance_class             = "${var.instance_type}"
  publicly_accessible        = false
  db_subnet_group_name       = "${aws_db_subnet_group.cluster.name}"
  engine                     = "aurora-mysql"
  apply_immediately          = true
  tags                       = "${merge(var.tags, map("Name", "${var.db_name}"))}"

}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier         = "cluster"
  database_name              = "mp"
  master_username            = "master"
  master_password            = "${var.db_pass}"
  engine                     = "aurora-mysql"
  db_subnet_group_name       = "${aws_db_subnet_group.cluster.name}"
  vpc_security_group_ids     = ["${aws_security_group.cluster.id}"]
  skip_final_snapshot        = "false"
  storage_encrypted          = true
  kms_key_id                 = "${aws_kms_key.rds.arn}"
  iam_roles                  = ["${aws_iam_role.rds.arn}"]
  final_snapshot_identifier  = "cluster-final-snap"
  apply_immediately          = true

  lifecycle { ignore_changes = ["master_password"] }
}
