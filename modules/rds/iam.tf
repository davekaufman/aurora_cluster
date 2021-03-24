resource "aws_iam_role" "rds" {
  name               = "rds"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "rds.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "rds" {
  name               = "rds"
  path               = "/"
  policy             = "${data.template_file.cluster_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "rds" {
  role               = "${aws_iam_role.rds.name}"
  policy_arn         = "${aws_iam_policy.rds.arn}"
}
