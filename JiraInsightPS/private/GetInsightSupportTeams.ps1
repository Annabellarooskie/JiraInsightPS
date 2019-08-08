function GetInsightSupportTeams {





[CmdletBinding()]
param (

)

begin {

    [xml] $configfile = Get-Content -Path $PSScriptRoot\config\jiraautomation.xml

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

}

process {

    try {

        $var = Get-OMTPasswordVaultEntry -UserName "svcVMProvisioner" -IncludePassword -Force

        $EncodedAuthorization = [System.Text.Encoding]::UTF8.GetBytes($var.UserName + ':' + ($var.Password))

        $EncodedPassword = [System.Convert]::ToBase64String($EncodedAuthorization)

        $header = @{

            'Content-Type'  = 'application/json'
            "Authorization" = "Basic $($EncodedPassword)"
        }

        $baseuri = $configfile.ServerConfiguration.url

        $vmobjecturi = "/rest/insight/1.0/objecttype/33/objects"

        $resturi = $baseuri + $vmobjecturi

        $results = Invoke-RestMethod -Method GET -Uri $resturi -headers $header -ErrorAction Stop

        write-output $results.name


    } catch {

        $_

    }


}

end {
}
}