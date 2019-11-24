provider "aws" {
  version     = "~> 2.39"
  access_key  = var.aws_access_key_id
  secret_key  = var.aws_secret_access_key
  region      = var.aws_region
}
