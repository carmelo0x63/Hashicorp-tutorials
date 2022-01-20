terraform {
  required_version = ">= 1.0.1"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.12"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

# Defining VM Volume
resource "libvirt_volume" "LibVirt-volume" {
  name   = var.vm_volume
  pool   = "tf_images"                           # List storage pools using `virsh pool-list`
#  source = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
  source = "/var/lib/libvirt/images2/CentOS-7-x86_64-GenericCloud.qcow2"
  format = "qcow2"
}

# get user data info
data "template_file" "user_data" {
  template = "${file("${path.module}/cloud_init.cfg")}"
}

# Use CloudInit to add the instance
resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "commoninit.iso"
  pool      = "tf_images"                        # List storage pools using `virsh pool-list`
  user_data = "${data.template_file.user_data.rendered}"
}

# Define KVM domain to create
resource "libvirt_domain" "LibVirt-domain" {
  name   = var.vm_hostname
  memory = "1024"
  vcpu   = 1

  network_interface {
    network_name   = "default"                   # List networks with `virsh net-list`
    wait_for_lease = "true"
  }

  disk {
    volume_id = "${libvirt_volume.LibVirt-volume.id}"
  }

  cloudinit = "${libvirt_cloudinit_disk.commoninit.id}"

  console {
    type        = "pty"
    target_type = "serial"
    target_port = "0"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

