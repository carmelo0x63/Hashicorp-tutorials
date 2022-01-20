variable "vm_hostname" {
  description = "VM hostname"
  default     = "cloud7-kvm"
}

variable "vm_volume" {
  description = "VM volume"
  default     = "cloud7.qcow2"
}

variable "virsh_vol" {
  description = "Virsh volume"
  default     = "tf_images"
}

variable "virsh_net" {
  description = "Virsh network"
  default     = "default"
}

variable "public_key" {
  default = "~/.ssh/tf_keys.pub"
}

variable "private_key" {
  default = "~/.ssh/tf_keys"
}

