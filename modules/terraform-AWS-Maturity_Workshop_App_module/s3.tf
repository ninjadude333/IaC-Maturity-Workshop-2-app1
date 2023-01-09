resource "aws_s3_bucket" "app-logs" {
  bucket        = "maturity-${var.Phase}-${var.app_name}-logs"
  force_destroy = true
  tags          = local.tags
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.app-logs.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_role.app_s3_access.arn}"
            },
            "Action": ["s3:GetObject", "s3:PutObject"],
            "Resource": "${aws_s3_bucket.app-logs.arn}/*"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_role.app_s3_access.arn}"
            },
            "Action": "s3:ListBucket",
            "Resource": "${aws_s3_bucket.app-logs.arn}"
        }
    ]
}
EOF
}

resource "aws_iam_role" "app_s3_access" {
  name               = "${var.Phase}-${var.app_name}_s3_access"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
}
EOF
}

resource "aws_iam_policy" "app-s3_access" {
  name   = "${var.Phase}-s3_access-${var.app_name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject"],
      "Resource": ["${aws_s3_bucket.app-logs.arn}/*"]
    },
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["${aws_s3_bucket.app-logs.arn}"]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "app-s3_access" {
  role       = aws_iam_role.app_s3_access.name
  policy_arn = aws_iam_policy.app-s3_access.arn
}

resource "aws_iam_instance_profile" "app_s3_access" {
  name = "${var.Phase}-${var.app_name}_s3_access"
  role = aws_iam_role.app_s3_access.name
  tags = local.tags
}