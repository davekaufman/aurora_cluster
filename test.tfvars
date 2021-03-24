cluster_size    = "3"
db_name         = "rds-cluster"
db_pass         = "FAKEFAKEFAKEFAKE"
dns_zone_name   = "test.daveops.org"
instance_type   = "db.t3.small"
jumpbox_cidr    = "192.0.2.1/32"
vpc_id          = "${data.aws_caller_identity.current.account_id}"

tags            = {
    environment = "prod"
    provisioner = "terraform"
}

cidr_rules      = []
sgid_rules      = []
