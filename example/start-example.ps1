## Init

# dot source
. "..\ps-xml-settings-mgmt.ps1"

# import xml
[Xml] $config_xml = [Xml] (Get-Content -Path ".\config.xml")
[System.Xml.XmlElement] $config_xml = $config_xml.get_DocumentElement()
$settings = $config_xml.settings # << IMPORTANT

## Main

Write-Host "All Settings: " -ForegroundColor yellow
Get-Setting -AllSettings | fl

Write-Host "Group Alpha: " -ForegroundColor yellow
Get-Setting -GroupName 'group-alpha' | fl

Write-Host "Setting 1 is: " -ForegroundColor yellow -NoNewLine; Write-Host "$(gs 'setting-1')"