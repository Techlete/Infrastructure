
variable "bucket_name" {
  type        = string
  description = "The S3 bucket name entry"
}

variable "acl" {
  type        = string
  description = "The S3 bucket ACL"
  default     = "private"
}

variable "tags" {
  type        = map(string)
  description = "The map of tags for the resource"
  default     = {}
}

variable "enable_versioning" {
  type        = bool
  description = "Do we wish to version this resource or not?"
  default     = true
}

variable "create_user" {
  type        = bool
  description = "Do we wish to create a user for this resource?"
  default     = true
}

variable "ses_push_account_ids" {
  type        = list(string)
  description = "Account IDs for SES policy"
  default     = []
}

variable "cors_allowed_origins" {
  type        = list(string)
  description = "CORS permitted origins"
  default     = ["*"]
}

variable "cors_allowed_headers" {
  type        = list(string)
  description = "CORS permitted headers"
  default     = []
}

variable "cors_allowed_methods" {
  type        = list(string)
  description = "CORS permitted HTTP method verbs"
  default     = ["HEAD"]
}
