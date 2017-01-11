A standardised way to retreive settings from an XML file - file must follow a convetion (see below).

## How to use

As long as your XML file contains this: 

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

We can read it in Powershell with: 

```powershell
    ## Init
    
    # dot source
    . ".\ps-xml-settings-mgmt.ps1"
    
    # import xml
    [Xml] $config_xml = [Xml] (Get-Content -Path ".\config.xml")
    [System.Xml.XmlElement] $config_xml = $config_xml.get_DocumentElement()
    $settings = $config_xml.settings # << IMPORTANT
    
    ## Main
    
    Write-Host "All Settings: "
    Get-Setting -AllSettings
    
    Write-Host "Group Alpha: "
    Get-Setting -GroupName 'group-alpha'
    
    $setting1 = Get-Setting 'setting-1'
    Write-Host "Setting 1 is: $setting1"
    
    # lazy
    gs 'setting-2'
```