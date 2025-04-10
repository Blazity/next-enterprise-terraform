variable "docker_image_tag" {
    type = string
}

variable "project_name" {
    type = string
}

variable "env" {
    type = string
}

variable "desired_count" {
    type = number
}

variable "node_env" {
    type = string
}

variable "logs_retention_in_days" {
    type = number
}