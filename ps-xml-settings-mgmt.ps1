function Get-Setting {
[CmdletBinding(DefaultParameterSetName="BySetting")]    

    param(
        [Parameter(Mandatory=$false, ParameterSetName="All")]
        [Switch] $AllSettings,
        
        [Parameter(Mandatory=$true, ParameterSetName="BySetting", Position=0)]
        [String] $SettingName,
        [Parameter(Mandatory=$false, ParameterSetName="BySetting")]
        [Switch] $ForDisplay,

        [Parameter(Mandatory=$true, ParameterSetName="ByGroup")]
        [String] $GroupName
    )

    $mode = $PSCmdlet.ParameterSetName

    function ToPsObject ($InputFragment) {

        $props = $InputFragment | Get-Member -MemberType Properties | 
            Select-Object -ExpandProperty Name
        $props_count = $props.Count

        $culture_info = [System.Threading.Thread]::CurrentThread.CurrentCulture.TextInfo
        # use $culture_info.toTitleCase()

        $storage = @()
        foreach ($fragment in $InputFragment) {

            $container = New-Object PSObject

            for ($i=0; $i -lt $props_count; $i++) {

                $this_property_name = $culture_info.toTitleCase($props[$i])
                $this_property_value = $fragment.$this_property_name

                $container | Add-Member -MemberType NoteProperty `
                    -Name  $this_property_name `
                    -Value $this_property_value 
                
            }

            $storage += $container

        }

        return $storage | Select-Object Name, Value, Description

    }

    try {

        if ($settings -eq $null) { throw '$settings variable is null' }

        switch ($mode) {
            "BySetting" {
                $xpath_results = $settings.SelectNodes("//setting[@name='$SettingName']")
                if ($xpath_results.length -eq 0) {throw "no settings found"}
                elseif ($xpath_results.length -gt 1) {throw "more than 1 setting found"}

                # return early if not for display
                if (-not $ForDisplay) {return $xpath_results.value}
            }
            "ByGroup" {
                $xpath_results = $settings.SelectNodes("//$GroupName/setting")
                if ($xpath_results.length -eq 0) {throw "no settings found"}
            }
            default {
                $xpath_results = $settings.SelectNodes("//setting")
            }
        }
    }

    catch {
        $msg = $Error[0].Exception.Message
        Write-Host -Message "ERROR in Get-Setting - MODE: $mode, MSG: $msg" -ForegroundColor Red
    }
		
    return ToPsObject $xpath_results

}

Set-Alias -Name "gs" -Value "Get-Setting"