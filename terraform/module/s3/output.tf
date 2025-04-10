output "s3_storybook_bucket_regional_domain_name" {
    value = aws_s3_bucket.storybook.bucket_domain_name
}

output "s3_storybook_bucket_origin_id" {
    value = aws_s3_bucket.storybook.id
}

output "s3_storybook_bucket_website_endpoint" {
    value = aws_s3_bucket_website_configuration.aws_s3_storybook_website.website_endpoint
}