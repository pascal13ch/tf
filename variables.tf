variable "region" {
    description = "AWS Region"
    default     = "eu-central-1" # Frankfurt
}

variable "instance_type" {
    description = "value"
    default     = "t2.micro"
}

variable "instance_hostname_prefix" {
    description = "Hostname Prefix"
    default     = "ubuntu"
}
