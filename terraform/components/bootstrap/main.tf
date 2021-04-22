locals {
  co_uk_domain          = "techlete.co.uk"
  uk_domain             = "techlete.uk"
}

module "route53_base" {
  source                = "../../modules/AwsDnsZoneRecord/"
  zone_name             = "${local.co_uk_domain}"
}

module "route53_uk" {
  source                = "../../modules/AwsDnsZoneRecord/"
  zone_name             = "${local.uk_domain}"
}
