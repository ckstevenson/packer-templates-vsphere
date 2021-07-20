os_version = "10"
os_family = "debian"
os_guest_id = "debian9_64Guest"
iso_path = "[Datastore] ISO/Linux/Debian/debian-10.8.0.iso"
iso_url = "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-10.8.0-amd64-netinst.iso"
iso_checksum = "396553f005ad9f86a51e246b1540c60cef676f9c71b95e22b753faef59f89bee"
root_disk_size = 61440
boot_command = [
  "<esc><wait>",
  "auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
  "<enter><wait>"
]
