data "template_file" "cluster_policy" {
  template  = "${file("${path.module}/templates/cluster_policy.tpl")}"
  vars {
    key_arn = "${aws_kms_key.rds.arn}"
  }
}
