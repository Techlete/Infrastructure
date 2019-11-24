output "acme_account_key" {
  description = "ACME account private key"
  value       = module.core_domain_plus_wildcard_tls.acme_account_key
}

output "certificate_domain" {
  value       = module.core_domain_plus_wildcard_tls.certificate_domain
}

output "certificate_url" {
  value       = module.core_domain_plus_wildcard_tls.certificate_url
}

output "certificate_pem" {
  value       = module.core_domain_plus_wildcard_tls.certificate_pem
}

output "certificate_private_key_pem" {
  value       = module.core_domain_plus_wildcard_tls.certificate_private_key_pem
}

output "certificate_issuer_pem" {
  value       = module.core_domain_plus_wildcard_tls.certificate_issuer_pem
}

output "certificate_fullchain_pem" {
  value       = module.core_domain_plus_wildcard_tls.certificate_fullchain_pem
}
