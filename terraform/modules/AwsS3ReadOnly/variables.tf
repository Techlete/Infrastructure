
variable "bucket_name" {
  type        = string
  description = "The S3 bucket name entry"
}

variable "bucket_arn" {
  type        = string
  description = "S3 bucket ARN"
}

variable "tags" {
  type        = map(string)
  description = "The map of tags for the resource"
  default     = {}
}