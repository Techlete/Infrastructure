locals {
  domain_co_uk          = "techlete.co.uk"
  domain_uk             = "techlete.uk"
  aws_ses_account_ids   = ["796949242666"]
  route53_base_zone_id  = "ZEIKOHSVJCA0Q"
  route53_uk_zone_id    = "Z06944992IET2RPFW73FP"
}

module "site_production_email_bucket" {
  source                = "../../modules/AwsS3WithUser/"
  bucket_name           = "ses.${local.domain_co_uk}"
  enable_versioning     = true
  create_user           = false
  ses_push_account_ids  = local.aws_ses_account_ids
}

module "site_production_uploads" {
  source                = "../../modules/AwsS3WithUser/"
  bucket_name           = "uploads.${local.domain_co_uk}"
  enable_versioning     = true
  create_user           = true
  cors_allowed_origins  = ["*"]
  cors_allowed_headers  = ["*"]
  cors_allowed_methods  = ["PUT", "POST"]
}

module "site_production_ses_email" {
  source                = "../../modules/AwsSESToBucket/"
  domain_name           = "${local.domain_co_uk}"
  mail_from_domain      = "mail.${local.domain_co_uk}"
  route53_zone_id       = local.route53_base_zone_id
  from_addresses        = ["${local.domain_co_uk}"]
  dmarc_rua             = "dmarc@${local.domain_co_uk}"
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

module "core_domain_plus_wildcard_tls" {
  source                = "../../modules/AwsLetsEncryptToAcm/"
  zone_id               = local.route53_base_zone_id
  domain                = local.domain_co_uk
  acme_email            = "tls@${local.domain_co_uk}"
  aws_region            = var.aws_region
  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
}

module "uk_domain_plus_wildcard_tls" {
  source                = "../../modules/AwsLetsEncryptToAcm/"
  zone_id               = local.route53_uk_zone_id
  domain                = local.domain_uk
  acme_email            = "tls@${local.domain_uk}"
  aws_region            = var.aws_region
  aws_access_key_id     = var.aws_access_key_id
  aws_secret_access_key = var.aws_secret_access_key
}
