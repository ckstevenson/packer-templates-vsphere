variable "vcenter_server" {
    type = string
    description = "vCenter server to build the VM on"
}
variable "vcenter_username" {
    type = string
    description = "Username to authenticate to vCenter"
}
variable "vcenter_password" {
    type = string
    description = "Password to authenticate to vCenter"
    sensitive = true
}
variable "vcenter_cluster" {
    type = string
    description = "vCenter cluster to build the VM on"
}
variable "vcenter_datacenter" {
    type = string
    description = "vCenter datacenter to build the VM on"
}
variable "vcenter_host" {
    type = string
    description = "ESXi host to build the VM on"
}
variable "vcenter_datastore" {
    type = string
    description = "Datastore host to build the VM on"
}
variable "vcenter_folder" {
    type = string
    description = "The vcenter folder to store the template"
}
variable "connection_username" {
    type = string
    description = "The username used to connect to the guest instance"
    default = "user"
}
variable "connection_password" {
    type = string
    description = "The password used to connect to the guest instance"
    default = "changeme"
}
variable "vm_hardware_version" {
    type = string
    description = "The VM hardware compatibility version"
    default = "13"
}
variable "os_family" {
    type = string
    description = "OS family used to build the paths and other settings"
}
variable "os_guest_id" {
    type = string
    description = "ID used by VMware to identify the guest OS"
}
variable "os_version" {}
variable "iso_url" {
    type = string
    description = "URL to pull the iso from"
    default = ""
}
variable "iso_path" {
    type = string
    description = "Sotrage path to pull the iso from"
    default = ""
}
variable "iso_checksum" {
    type = string
    description = "Checksum for the iso file pulled from the net"
    default = ""
}
variable "root_disk_size" {
    type = number
    description = "Root disk size in MiB"
}
variable "nic_type" {
    type = string
    description = "NIC type for the VM"
    default = "vmxnet3"
}
variable "vm_network" {
    type = string
    description = "VLAN  for the VM"
    default = "VM_VLAN6"
}
variable "num_cpu" {
    type = number
    description = "Number of CPUs for the VM"
    default = 2
}
variable "num_cores" {
    type = number
    description = "Number of CPU cores for the VM"
    default = 1
}
variable "vm_ram" {
    type = number
    description = "RAM in MiB for the VM"
    default = 4096
}
variable "ansible_playbooks" {
    description = "The URL for Ansible Playbooks to provision the system"
}
variable "boot_command" {}
