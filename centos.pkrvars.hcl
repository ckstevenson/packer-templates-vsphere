os_version = "stream8"
os_family = "centos"
os_guest_id = "centos7_64Guest"
iso_path = "[Datastor] ISO/Linux/Centos/centos-stream8.iso"
iso_url = "https://centos.mirror.iphh.net/CentOS/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-20210721-dvd1.iso"
iso_checksum = "9fc31f0853683175d4aa76e31a5b23ddfe51e477b114e1410401c6cf82f5b7cb"
root_disk_size = 61440
boot_command = ["<tab>",
                " text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg",
                "<enter><wait>"
]
