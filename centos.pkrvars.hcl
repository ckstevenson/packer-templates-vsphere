os_version = "stream8"
os_family = "centos"
os_guest_id = "centos7_64Guest"
iso_path = "[Datastore] ISO/Linux/Centos/centos-stream8.iso"
iso_url = "https://centos.mirror.iphh.net/CentOS/8-stream/isos/x86_64/CentOS-Stream-8-x86_64-20210311-dvd1.iso"
iso_checksum = "13335ab0d39f430a8cf1c0383359a1aa4861541511aceb5615325e8e06e6ac82"
root_disk_size = 61440
boot_command = ["<tab>",
                " text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/kickstart.cfg",
                "<enter><wait>"
]
