# Output server IP
output "ip" {
  value = "${libvirt_domain.LibVirt-domain.network_interface[0].addresses[0]}"
}

