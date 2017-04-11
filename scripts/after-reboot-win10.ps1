$ErrorAction='SilentlyContinue'
$ProgressPreference='SilentlyContinue'

Get-WUInstall -WindowsUpdate -AcceptAll -UpdateType Software -IgnoreReboot

Write-Host "Attempting to uninstall features..."
Get-WindowsOptionalFeature -Online | ? { $_.State -eq 'Disabled' } `
  | foreach { $_.FeatureName; Disable-WindowsOptionalFeature -Online `
  -Remove -FeatureName $_.FeatureName
    Write-Host "Uninstall succeeded!" }
