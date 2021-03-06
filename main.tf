resource "aws_s3_bucket" "static_react_bucket" {
  bucket = var.bucket_name

  tags = {
    Projeto = "HMV"
  }

}

resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.static_react_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_acl" "static_react_bucket_acl" {
  bucket = aws_s3_bucket.static_react_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "static_react_bucket_versioning" {
  bucket = aws_s3_bucket.static_react_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "react_app_s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.static_react_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [var.cloudfront_oai_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "react_app_bucket_policy" {
  bucket = aws_s3_bucket.static_react_bucket.id
  policy = data.aws_iam_policy_document.react_app_s3_policy.json
}