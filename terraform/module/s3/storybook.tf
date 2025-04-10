resource "aws_s3_bucket" "storybook" {
    bucket = var.s3_storybook_name
    # in case we want to force deletion on PROD too, the below line needs to be changed.
    force_destroy = var.env == "prod" ? false : true
    
    tags = {
        Name        = var.s3_storybook_name
        Environment = var.env
    }
}

resource "aws_s3_bucket_ownership_controls" "aws_s3_storybook_ownership" {
    bucket = aws_s3_bucket.storybook.id

    rule {
        object_ownership = "BucketOwnerPreferred"
    }
}

resource "aws_s3_bucket_versioning" "aws_s3_storybook_versioning" {
    bucket = aws_s3_bucket.storybook.id

    versioning_configuration {
        status = var.env == "prod" ? "Enabled" : "Disabled" 
    }
}

resource "aws_s3_bucket_public_access_block" "aws_s3_storybook_public_access" {
    bucket = aws_s3_bucket.storybook.id

    restrict_public_buckets = false
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
}

resource "aws_s3_bucket_acl" "example" {
    depends_on = [
        aws_s3_bucket_ownership_controls.aws_s3_storybook_ownership,
        aws_s3_bucket_public_access_block.aws_s3_storybook_public_access
    ]

    bucket = aws_s3_bucket.storybook.id
    acl    = "private"
}

resource "aws_s3_bucket_cors_configuration" "aws_s3_storybook_cors" {
    bucket = aws_s3_bucket.storybook.id

    cors_rule {
        allowed_headers = ["*"]
        allowed_methods = ["GET", "HEAD"]
        allowed_origins = var.s3_storybook_cors_domains
        expose_headers  = ["ETag"]
        max_age_seconds = 3000
    }
}

resource "aws_s3_bucket_website_configuration" "aws_s3_storybook_website" {
    bucket = aws_s3_bucket.storybook.id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
}