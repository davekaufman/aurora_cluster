# account_id          = "${data.aws_caller_identity.current.account_id}"
backend_subnet_name = "backend" # assumes all backend subnets have same 'Name' tag - see data.tf
cluster_size        = "3"
db_name             = "rds-cluster"
db_pass             = "FAKEFAKEFAKEFAKE"
db_subnet_name      = "databases" # same assumption as backend_subnet_name
dns_zone_name       = "test.daveops.org" # omit trailing .
instance_type       = "db.t3.small"
jumpbox_cidr        = "192.0.2.1/32"
vpc_name            = "Default"

tags            = {
    environment = "prod"
    provisioner = "terraform"
}

# extra cidr or security-group-id based rules, as a list of maps. see modules/rds/sg.tf for details
cidr_rules      = []
sgid_rules      = []
