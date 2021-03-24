variable "backend_subnet_cidrs" { type    = "list"   }
variable "cidr_rules"           { type    = "list"   }
variable "cluster_size"         { type    = "string" }
variable "instance_type"        { type    = "string" }
variable "db_name"              { type    = "string" }
variable "db_pass"              { type    = "string" }
variable "db_port"              { default = 3306     }
variable "db_subnets"           { type    = "list"   }
variable "dns_zone_id"          { type    = "string" }
variable "dns_zone_name"        { type    = "string" }
variable "jumpbox_cidr"         { type    = "string" }
variable "sgid_rules"           { type    = "list"   }
variable "tags"                 { type    = "map"    }
variable "vpc_id"               { type    = "string" }