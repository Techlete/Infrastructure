provider "aws" {
  version     = "~> 2.39"
  access_key  = var.aws_access_key_id
  secret_key  = var.aws_secret_access_key
  region      = var.aws_region
}

provider "acme" {
  version     = "~> 1.5"
  server_url  = "https://acme-v02.api.letsencrypt.org/directory"
}

provider "tls" {
  version     = "~> 2.1"
}