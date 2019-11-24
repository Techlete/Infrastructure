output "private_key" {
  description = "Private Key used when registering with LetsEncrypt"
  value       = length(var.acme_private_key) > 0 ? null : tls_private_key.acme[0].private_key_pem
}

output "acme_account_key" {
  description = "ACME account private key"
  value       = length(var.acme_private_key) > 0 ? var.acme_private_key : acme_registration.acme[0].account_key_pem
}

output "certificate_domain" {
  value       = acme_certificate.acme.certificate_domain
}

output "certificate_url" {
  value       = acme_certificate.acme.certificate_url
}

output "certificate_pem" {
  value       = acme_certificate.acme.certificate_pem
}

output "certificate_private_key_pem" {
  value       = acme_certificate.acme.private_key_pem
}

output "certificate_issuer_pem" {
  value       = acme_certificate.acme.issuer_pem
}

output "certificate_fullchain_pem" {
  value       = "${acme_certificate.acme.certificate_pem}${acme_certificate.acme.issuer_pem}"
}
