source "vsphere-iso" "ubuntu-live-server" {
  vcenter_server      = var.vsphere_server
  username            = var.vsphere_user
  password            = var.vsphere_password
  insecure_connection = "true"
  datastore           = var.vsphere_datastore
  host                = var.vsphere_host

  vm_name         = var.vm_name
  CPUs            = 2
  RAM             = 4096
  RAM_reserve_all = true
  guest_os_type   = "ubuntu64Guest"
  iso_checksum    = var.os_iso_checksum
  iso_urls = [
    "iso/${var.os_iso_name}",
    var.os_iso_url
  ]

  http_directory    = "http"
  http_ip           = var.http_ip
  http_bind_address = var.http_bind_address
  http_port_min     = var.http_port
  http_port_max     = var.http_port

  network_adapters {
    network      = var.vsphere_network
    network_card = "vmxnet3"
  }

  storage {
    disk_size             = var.vm_disk_size
    disk_thin_provisioned = true
  }

  communicator           = "ssh"
  ssh_username           = var.ssh_username
  ssh_password           = var.ssh_password
  ssh_private_key_file   = var.ssh_private_key_file
  ssh_pty                = true
  ssh_handshake_attempts = 2000
  ssh_timeout            = "30m"

  boot_wait           = "5s"
  convert_to_template = true
  create_snapshot     = false

  boot_command = [
    "<enter><enter><f6><esc><wait> ",
    "autoinstall ds=nocloud-net;seedfrom=http://{{ .HTTPIP }}:${var.http_port_boot}/${var.os_type}/${var.os_version}/",
    "<enter><wait>"
  ]


  shutdown_command = "echo '${var.ssh_password}' | sudo -S shutdown -P now"

  configuration_parameters = {
    "disk.EnableUUID" = "true"
  }
}

build {
  sources = [
    "source.vsphere-iso.ubuntu-live-server",
  ]

  provisioner "ansible" {
    playbook_file           = "ansible/playbook.yml"
    user                    = var.ssh_username
    use_proxy               = false
    ssh_authorized_key_file = var.ssh_private_key_file
    inventory_file_template = "{{ .HostAlias }} ansible_host={{ .Host }} ansible_user={{ .User }} ansible_port={{ .Port }} ansible_ssh_private_key_file='${var.ssh_private_key_file}'"
  }
}