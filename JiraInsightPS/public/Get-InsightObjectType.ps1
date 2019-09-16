<#
.SYNOPSIS
 This public cmdlet queries and returns the possible object types for a Jira Insight Schema.  The Schema is defined in the configuration file for the module.
 It returns both the ObjectType Name and ObjectType ID.

.EXAMPLE
Get-InsightObjectType

.NOTES
The authentication to Jira Insight is managed by the config file for the username, and assumes you have stored the password in the Credential Manager on the Windows System prior
to running the cmdlet.
#>

function Get-InsightObjectType {

    [CmdletBinding()]
    param (

    )

    begin {


        Set-StrictMode -Version Latest

        $ErrorActionPreference = 'Stop'

    }

    process {

        try {

            $ObjectTypes = GetInsightObjTypeMapping

            Write-Output $ObjectTypes

        } catch {

            Write-Error -ErrorAction Continue -Exception $_.Exception

        }


    }


}
