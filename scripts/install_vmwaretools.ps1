$VerbosePreference = "Continue"

$wmi_operatingsystem = Get-WmiObject -Class win32_operatingsystem
$url = 'https://packages.vmware.com/tools/releases/latest/windows/x64/VMware-tools-11.2.5-17337674-x86_64.exe'

# install vmware tools
$file = 'tools.exe'
$path = "C:\Windows\Temp\$file"
$timeout = 30 # Timeout in minutes for it to fail this job
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($url,$path)
$args = '/s /v /qn reboot=r'
Write-Verbose "Tools download successful.  Install starting."
$timer = [Diagnostics.Stopwatch]::StartNew()
Start-Process -FilePath $path -ArgumentList $args -PassThru

function Test-VMInstall {
    $RegKey = (Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\')

    foreach ($key in $RegKey) {
        if ((Get-ItemProperty -Path $key.PSPath).DisplayName -match "vmware") {
            return $true
        }
    }
    return $false
}

#$toolswait = $true

While ($toolswait){
    if(!(Test-VMInstall)){
        if($timer.Elaspsed.TotalMinutes -gt $timeout) {
            Write-Verbose "Tools not detected within timeout.  Failing job."
            Exit 1
        }
        Write-Verbose "Tools not detected yet."
        Write-Verbose "Time left until timeout: $([math]::Round($timeout - $timer.Elapsed.TotalMinutes)) minutes."
        Write-Verbose "Sleeping 10 seconds before checking again."
        Start-Sleep -Seconds 10
    } else {
        $toolswait = $false
    }
}

#Write-Verbose "VMTools detected, sleeping 200 seconds for installer cleanup."
#Start-Sleep -Seconds 200
