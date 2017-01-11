# PS XML Settings Managment

A standardised way to retreive settings from an XML file.

Grouping is there more to help human readability, you don't need to specify the group when fetching a setting.

## How to use

Settings must be defined within the file like below. 

```xml
<settings>
    <general>
        <setting name="setting-1" value="11" desc="setting 1 desc"/>
        <setting name="setting-2" value="22" desc="setting 2 desc" />
    </general>
    <group-alpha>
        <setting name="group-1-setting1" value="g1s1" days="one does not simply" />
        <setting name="group-1-setting2" value="g1s2" days="one not simply does" />
        <setting name="group-1-setting3" value="g1s3" days="simply does one not" />
    </group-alpha>
    <group-bravo>
        <setting name="group-2-setting" value="g2s" description="read the" />
    </group-bravo>
    <group-charlie>
        <setting name="group-3-setting" value="g3s" description="description" />
    </group-charlie>
</settings>
```

Dot source the file into your script like below.
``` powershell
. ".\ps-xml-settings-mgmt.ps1"
```

Import the XML file and define a $settings varibale like so.
```powershell
[Xml] $config_xml = [Xml] (Get-Content -Path ".\config.xml")
[System.Xml.XmlElement] $config_xml = $config_xml.get_DocumentElement()

$settings = $config_xml.settings # << IMPORTANT
```

Ready to roll
```powershell
Write-Host "All Settings: "
Get-Setting -AllSettings

Write-Host "Group Alpha: "
Get-Setting -GroupName 'group-alpha'

$setting1 = Get-Setting 'setting-1'
Write-Host "Setting 1 is: $setting1"

# gs.lazy
gs 'setting-2'
```