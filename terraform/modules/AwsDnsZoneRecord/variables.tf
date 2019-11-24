
variable "zone_name" {
  type        = string
  description = "The domain DNS name entry"
}

variable "tags" {
  type        = map(string)
  description = "The map of tags for the resource"
  default     = {}
}