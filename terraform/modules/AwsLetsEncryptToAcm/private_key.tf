resource "tls_private_key" "acme" {
  count       = length(var.acme_private_key) > 0 ? 0 : 1
  algorithm   = var.private_key_algorithm
  rsa_bits    = var.key_bits
  ecdsa_curve = var.ecdsa_curve
}