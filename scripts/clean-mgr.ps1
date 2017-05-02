$ProgressPreference='SilentlyContinue'

$regKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches"
$state = "StateFlags0100"

Get-ChildItem $regKey | ForEach-Object {
    New-ItemProperty -Path $_.PSPath -Name $state -Value 2 -PropertyType DWord -Force | Out-Null
}

if (Test-Path "$env:SystemRoot\SYSTEM32\cleanmgr.exe") {
  Start-Process -Wait cleanmgr -ArgumentList "/sagerun:100"
}
