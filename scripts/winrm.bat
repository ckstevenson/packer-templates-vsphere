:: Current WinRM settings
:: winrm get winrm/config

:: Disable firewall (enabled later with Ansible and F-Secure)
cmd.exe /c "Netsh Advfirewall set allprofiles state off"

:: Set 32 and 64 bit execution policy
cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force"
C:\Windows\SysWOW64\cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force"

:: Configure WinRM
start "" /WAIT cmd.exe /c net stop winrm
cmd.exe /c winrm quickconfig -q
cmd.exe /c winrm quickconfig -transport:http
::cmd.exe /c winrm quickconfig -transport:https
cmd.exe /c winrm set winrm/config @{MaxTimeoutms="1800000"}
cmd.exe /c winrm set winrm/config/winrs @{MaxMemoryPerShellMB="2048"}
cmd.exe /c winrm set winrm/config/service @{AllowUnencrypted="true"}
::cmd.exe /c winrm set winrm/config/service/auth @{Basic="true"}
::cmd.exe /c winrm set winrm/config/client/auth @{Basic="true"}
cmd.exe /c winrm set winrm/config/listener?Address=*+Transport=HTTP @{Port="5985"}
::cmd.exe /c winrm set winrm/config/listener?Address=*+Transport=HTTPS @{Port="5986"}
::
:::: Start WinRM
cmd.exe /c sc config winrm start=auto
cmd.exe /c net start winrm
