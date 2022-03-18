variable "bucket_name" {
  type        = string
  default     = "fiap-hmv-react-bucket"
}

variable "cloudfront_oai_arn" {
  type        = string
  default     = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E1FZQP5DTOTQXX"
}
