function ConnectJiraInsight {

    [CmdletBinding()]

    param (

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Config


    )

    try {

        $ErrorActionPreference = "Stop"

        Set-JiraConfigServer -Server $Config.Connection.ServerConfigurationUrl

        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

        $VaultAccount = Get-OMTPasswordVaultEntry -UserName $Config.Connection.UserName -IncludePassword -Force

        $EncodedAuthorization = [System.Text.Encoding]::UTF8.GetBytes($VaultAccount.UserName + ':' + ($VaultAccount.Password))

        $EncodedPassword = [System.Convert]::ToBase64String($EncodedAuthorization)

        Write-Output $EncodedPassword

    } catch {

        Write-Error -ErrorAction Stop -Exception $_.Exception

    }
}

