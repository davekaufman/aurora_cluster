output "rds_key" {
  description = "key arn of rds encryption key"
  value       = "${aws_kms_key.rds.arn}"
}
