locals {
  domain                = "techlete.co.uk"
  aws_ses_account_ids   = ["796949242666"]
  route53_base_zone_id  = "ZEIKOHSVJCA0Q"
}

module "site_production_email_bucket" {
  source                = "../../modules/AwsS3WithUser/"
  bucket_name           = "ses.${local.domain}"
  enable_versioning     = true
  create_user           = false
  ses_push_account_ids  = local.aws_ses_account_ids
}

module "site_production_uploads" {
  source                = "../../modules/AwsS3WithUser/"
  bucket_name           = "uploads.${local.domain}"
  enable_versioning     = true
  create_user           = true
  cors_allowed_origins  = ["*"]
  cors_allowed_headers  = ["*"]
  cors_allowed_methods  = ["PUT", "POST"]
}

module "site_production_ses_email" {
  source                = "../../modules/AwsSESToBucket/"
  domain_name           = "${local.domain}"
  mail_from_domain      = "mail.${local.domain}"
  route53_zone_id       = local.route53_base_zone_id
  from_addresses        = ["${local.domain}"]
  dmarc_rua             = "dmarc@${local.domain}"
  receive_s3_bucket     = module.site_production_email_bucket.bucket_name
  receive_s3_prefix     = "inbox"
  ses_rule_set          = "ses-production-ruleset"
  custom_spf            = "v=spf1 include:amazonses.com -all"
}

resource "aws_ses_receipt_rule_set" "ses-production-ruleset" {
  rule_set_name         = "ses-production-ruleset"
}

resource "aws_ses_active_receipt_rule_set" "set-ruleset-as-primary-active" {
  rule_set_name = "ses-production-ruleset"
  depends_on            = [aws_ses_receipt_rule_set.ses-production-ruleset]
}
