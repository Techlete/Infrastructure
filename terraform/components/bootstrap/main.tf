locals {
  domain                = "techlete.co.uk"
}

module "route53_base" {
  source                = "../../modules/AwsDnsZoneRecord/"
  zone_name             = "${local.domain}"
}
