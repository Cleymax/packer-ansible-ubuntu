variable "vsphere_server" {
  type = string
}

variable "vsphere_user" {
  type = string
}

variable "vsphere_password" {
  type = string
  sensitive = true
}

variable "vsphere_datacenter" {
  type = string
}

variable "vsphere_host" {
  type = string
}

variable "vsphere_datastore" {
  type = string
}

variable "vsphere_network" {
  type = string
}

variable "os_type" {
  type = string
}

variable "os_version" {
  type = string
}

variable "os_iso_url" {
  type = string
}

variable "os_iso_name" {
  type = string
}

variable "os_iso_checksum" {
  type = string
}

variable "vm_name" {
  type = string
}

variable "vm_disk_size" {
  type = number
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "ssh_password" {
  type    = string
  default = "Linux"
  sensitive = true
}

variable "ssh_private_key_file" {
  type = string
  sensitive = true
}

variable "http_ip" {
  type    = string
}

variable "http_bind_address" {
  type    = string
  default = "0.0.0.0"
}

variable "http_port" {
  type    = number
  default = 8888
}

variable "http_port_boot" {
  type    = number
  default = 8888
}