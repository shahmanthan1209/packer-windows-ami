<powershell>
winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="2048"}'
winrm set winrm/config '@{MaxTimeoutms="7200000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
netsh advfirewall firewall add rule name="WinRM 5986" protocol=TCP dir=in localport=5986 action=allow

net stop winrm
sc config winrm start=auto
net start winrm

Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine

$EC2SettingsFile="C:\\Program Files\\Amazon\\Ec2ConfigService\\Settings\\Config.xml"
$xml = [xml](get-content $EC2SettingsFile)
$xmlElement = $xml.get_DocumentElement()
$xmlElementToModify = $xmlElement.Plugins

foreach ($element in $xmlElementToModify.Plugin) {
  if ($element.name -eq "Ec2SetPassword") {
    $element.State="Enabled"
  }
  elseif ($element.name -eq "Ec2SetComputerName") {
    $element.State="Enabled"
  }
  elseif ($element.name -eq "Ec2HandleUserData") {
    $element.State="Enabled"
  }
}
$xml.Save($EC2SettingsFile)

</powershell>