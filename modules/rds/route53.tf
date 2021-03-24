resource "aws_route53_record" "rds" {
  zone_id = "${var.dns_zone_id}"
  name    = "rds.${var.dns_zone_name}"
  type    = "CNAME"
  records =[ "${aws_rds_cluster.cluster.endpoint}" ]
  ttl     = 60
}
