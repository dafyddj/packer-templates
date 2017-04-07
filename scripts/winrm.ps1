#netsh advfirewall firewall add rule name="WinRM-HTTP" dir=in localport=5985 protocol=TCP action=allow
Start-Transcript -Path $env:TEMP\WINRM.PS1.log

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force
Set-NetConnectionProfile -NetworkCategory Private

winrm quickconfig -q
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'

Stop-Transcript
