function GetVaultPassword {

    [CmdletBinding()]

    param (

    )

    begin {

        Set-StrictMode -Version Latest

        $ErrorActionPreference = 'Stop'

    }

    process {

        try {

            $VaultAccount = Get-VaultEntry -UserName $M_Config.Connection.UserName -IncludePassword -Force

            $EncodedAuthorization = [System.Text.Encoding]::UTF8.GetBytes($VaultAccount.UserName + ':' + ($VaultAccount.Password))

            $EncodedPassword = [System.Convert]::ToBase64String($EncodedAuthorization)

            Write-Output $EncodedPassword

        } catch {

            Write-Error -ErrorAction Stop -Exception $_.Exception

        }

    }
}

