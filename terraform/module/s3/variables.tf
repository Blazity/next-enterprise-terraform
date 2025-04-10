variable "s3_storybook_name" {
    type = string
}

variable "s3_storybook_cors_domains" {
    type = list(string)
}

variable "env" {
    type = string
}
