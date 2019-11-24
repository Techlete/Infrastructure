variable "domain" {
  type        = string
  description = "Domain name"
}

variable "zone_id" {
  type        = string
  description = "AWS Route53 Zone ID"
}

variable "key_bits" {
  type        = number
  description = "Number of bits for requested TLS certificate. Values: 2048, 4096, 8192"
  default     = 4096
}

variable "must_staple" {
  type        = bool
  description = "Enables the OCSP Stapling Required TLS Security Policy extension"
  default     = true
}

variable "acme_email" {
  type        = string
  description = "The email to register an ACME account"
}

variable "acme_private_key" {
  type        = string
  description = "The ACME account private key (optional) to keep one account with multiple certificates"
  default     = ""
}

variable "private_key_algorithm" {
  type        = string
  description = "The algorithm to use generating a private key if not supplied. Values 'RSA', 'ECDSA'"
  default     = "RSA"
}

variable "ecdsa_curve" {
  type        = string
  description = "When algorithm is 'ECDSA', the name of the elliptic curve to use. Values: 'P224', 'P256', 'P384', 'P521'"
  default     = "P224"
}