variable "zone_id" {
  type        = string
  description = "The Route53 zone id"
}

variable "name" {
  type        = string
  description = "The Route53 zone name"
}

variable "type" {
  type        = string
  description = "The Route53 record type"
}

variable "ttl" {
  type        = string
  description = "The Route53 ttl"
  default     = 300
}

variable "records" {
  type        = list(string)
  description = "The record values"
  default     = []
}