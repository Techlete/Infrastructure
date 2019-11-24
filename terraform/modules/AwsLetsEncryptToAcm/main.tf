resource "acme_registration" "acme" {
  count                     = length(var.acme_private_key) > 0 ? 0 : 1
  account_key_pem           = tls_private_key.acme[0].private_key_pem
  email_address             = var.acme_email
  depends_on                = [tls_private_key.acme]
}

resource "acme_certificate" "acme" {
  account_key_pem           = length(var.acme_private_key) > 0 ? var.acme_private_key : acme_registration.acme[0].account_key_pem
  common_name               = var.domain
  subject_alternative_names = ["*.${var.domain}"]
  key_type                  = var.key_bits
  must_staple               = var.must_staple

  dns_challenge {
    provider                = "route53"

    config      = {
      AWS_HOSTED_ZONE_ID = var.zone_id
      AWS_REGION = var.aws_region
      AWS_ACCESS_KEY_ID = var.aws_access_key_id
      AWS_SECRET_ACCESS_KEY = var.aws_secret_access_key
    }
  }
  depends_on                = [acme_registration.acme]
}
