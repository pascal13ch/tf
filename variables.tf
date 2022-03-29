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

variable "instance_count" {
  description   = "number of VMs to create"
  type          = number
  default       = 1
  validation {
    condition       = var.vm_count >= 1
    error_message   = "Der Wert muss mindestens 1 sein."
  }
}

variable "instance_cpu" {
  description   = "number of CPUs per VM"
  type          = number
  default       = 1
  validation {
    condition       = var.vm_cpu >= 1
    error_message   = "Der Wert muss mindestens 1 sein."
  }
}

variable "instance_mem" {
  description   = "number of GBit Memory per VM"
  type          = number
  default       = 1
  validation {
    condition       = var.vm_cpu >= 1
    error_message   = "Der Wert muss mindestens 1 sein."
  }
}
