variable "vm_hostname" {
  description = "VM hostname"
  default     = "cloud7-kvm"
}

variable "vm_volume" {
  description = "VM volume"
  default     = "cloud7.qcow2"
}

variable "public_key" {
  default = "~/.ssh/tf_keys.pub"
}

variable "private_key" {
  default = "~/.ssh/tf_keys"
}

