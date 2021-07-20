source "vsphere-iso" "windows" {
  # vCenter settings
  vcenter_server      = var.vcenter_server
  username            = var.vcenter_username
  password            = var.vcenter_password
  insecure_connection = true
  cluster             = var.vcenter_cluster
  datacenter          = var.vcenter_datacenter
  host                = var.vcenter_host
  datastore           = var.vcenter_datastore
  convert_to_template = true
  folder              = var.vcenter_folder

  # VM Settings
  communicator          = "winrm"
  winrm_username        = var.connection_username
  winrm_password        = var.connection_password
  winrm_port            = "5985"
  winrm_use_ntlm        = true
  vm_version            = var.vm_hardware_version
  iso_paths              = [var.iso_path]
  iso_checksum          = var.iso_checksum
  vm_name               = "win-${ var.os_version }-80GB"
  guest_os_type         = var.os_guest_id
  disk_controller_type  = ["pvscsi"]
  network_adapters {
    # For windows, the vmware tools network drivers are required to be connected by floppy before tools is installed
    network = var.vm_network
    network_card = var.nic_type
  }
  storage {
    disk_size = var.root_disk_size
    disk_thin_provisioned = true
  }
  CPUs                  = var.num_cpu
  cpu_cores             = var.num_cores
  RAM                   = var.vm_ram
  floppy_files          = [
      "./boot_config/${ var.os_family }/${ var.os_version }/Autounattend.xml",
      "./scripts/winrm.bat",
      "./scripts/install_vmwaretools.ps1",
      "./scripts/winrm_mem_hotfix.ps1",
      "./drivers/"
  ]
}

source "vsphere-iso" "linux" {
  # vCenter settings
  vcenter_server      = var.vcenter_server
  username            = var.vcenter_username
  password            = var.vcenter_password
  insecure_connection = true
  cluster             = var.vcenter_cluster
  datacenter          = var.vcenter_datacenter
  host                = var.vcenter_host
  datastore           = var.vcenter_datastore
  convert_to_template = true
  folder              = var.vcenter_folder
  http_directory      = "./boot_config/${ var.os_family }/${ var.os_version }"

  # VM Settings
  ssh_username          = var.connection_username
  ssh_password          = var.connection_password
  ssh_port              = "22"
  ssh_handshake_attempts = "20"
  vm_version            = var.vm_hardware_version
  iso_url               = var.iso_url
  iso_paths              = [var.iso_path]
  iso_checksum          = var.iso_checksum
  vm_name               = "${ var.os_family }-${ var.os_version }-60GB"
  guest_os_type         = var.os_guest_id
  disk_controller_type  = ["pvscsi"]
  network_adapters {
    network = var.vm_network
    network_card = var.nic_type
  }
  storage {
    disk_size = var.root_disk_size
    disk_thin_provisioned = true
  }
  CPUs                  = var.num_cpu
  cpu_cores             = var.num_cores
  RAM                   = var.vm_ram
  #boot_wait            = "5s"
  boot_command          = var.boot_command
}

build {
    # Windows builds
    sources = [
        "source.vsphere-iso.windows",
    ]
    provisioner "ansible" {
        playbook_file = "${ var.ansible_playbooks }/windows_provisioner.yml"
        user = "user"
        use_proxy = false
        extra_arguments = [
            "--vault-password-file", 
            "${ var.ansible_playbooks }/vault_pwd", 
            "--extra-vars",
            "ansible_winrm_transport=ntlm"
        #    "-vvv"
        ]
    }
}

build {
    sources = [
        "source.vsphere-iso.linux",
    ]
    provisioner "ansible" {
        playbook_file = "${ var.ansible_playbooks }/linux_provisioner.yml"
        user = "user"
        #use_proxy = false
        extra_arguments = [
            "-b",
            "--extra-vars",
            "ansible_become_password=changeme",
            "--vault-password-file", 
            "${ var.ansible_playbooks }/vault_pwd"
            #"-vvv"
        ]
    }
}
