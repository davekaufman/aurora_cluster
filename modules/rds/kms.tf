resource "aws_kms_key" "rds" {
	description = "used to encrypt RDS data"
}

resource "aws_kms_alias" "rds" {
  name          = "alias/rds"
  target_key_id = "${aws_kms_key.rds.key_id}"
}
