provider "aws" {
  profile = "${var.aws_profile}"
  region = "us-east-1"
}

#########
#  IAM  #
#########

resource "aws_iam_user" "s3-user" {
  name = "${var.iam_user_name}"
}

resource "aws_iam_access_key" "s3-user" {
  user = "${aws_iam_user.s3-user.name}"
}

resource "aws_iam_user_policy" "s3-policy" {
  name = "s3-policy"
  user = "${aws_iam_user.s3-user.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1532723878817",
      "Action": "s3:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

########
#  S3  #
########

resource "aws_s3_bucket" "s3-bucket" {
  bucket = "${var.bucket_name}"

  cors_rule {
    allowed_methods = ["GET"]
    allowed_headers = ["Authorization"]
    allowed_origins = ["*"]
  }

  cors_rule {
    allowed_origins = ["*"]
    allowed_headers = ["*"]
    allowed_methods = ["PUT","POST"]
  }
}

resource "aws_s3_bucket_policy" "s3-bucket-policy" {
  bucket = "${aws_s3_bucket.s3-bucket.id}"

  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[
    {
      "Sid": "Stmt1526330824446",
      "Effect": "Allow",
      "Principal": {
        "AWS": "${aws_iam_user.s3-user.arn}"
      },
      "Action": "s3:*",
      "Resource": ["${aws_s3_bucket.s3-bucket.arn}/*"]
    },
    {
      "Sid":"AllowRead",
      "Effect":"Allow",
      "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["${aws_s3_bucket.s3-bucket.arn}/*"]
    }
  ]
}
EOF
}


