variable "aws_profile" {
  description = "The aws profile name set up in your environment"
  default = "roundtable"
}


variable "bucket_name" {
  description = "What do you want your bucket to be called?"
  default = "astest"
}


variable "iam_user_name" {
  description = "What do you want your IAM user to be called?"
  default = "astest-user"
}
