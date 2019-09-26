<#
.SYNOPSIS
This public cmdlet queries and returns the Jira Insight object attributes and their valies for a Jira Insight Schema and top level ObjectType.
Both of which are defined in the configuration file for the module.

.PARAMETER TypeID
This parameter is used to return all the objects attributes/values of a certain type. It is most often used in conjunction with the Get-InsightObjectType cmdlet.
It is mutually exclusive to the DeviceName and IQL parameters.

.PARAMETER DeviceName
This parameter is used to return all the objects attributes/values of a certain name.  This parameter does both exact name and partial matching on the string.  Do not use wildcard characters.
It is mutually exclusive to the TypeID and IQL parameters.

.PARAMETER IQL
This parameter is used to return all the objects attributes/values from an IQL query.  It is mutually exclusive to the TypeID and DeviceName parameters.


.EXAMPLE
Get-InsightObjectAttr -TypeID 32
Get-InsightObjectAttr -DeviceName WAPDEVICE-01
Get-InsightObjectAttr -DeviceName WAPDEVICE-01 -TypeID 32
Get-InsightObjectAttr -IQL '"OS Version" IN ("Microsoft Windows XP Professional (32-bit)") AND objectType IN ("Virtual Machine")'

.NOTES
The authentication to Jira Insight is managed by the config file for the username, and assumes you have stored the password in the Credential Manager on the Windows System prior
to running the cmdlet.
#>
function Get-InsightObjectAttr {

    [CmdletBinding()]
    param (

        [Parameter(ParameterSetName = 'Generic')]
        [int]
        $TypeId,

        [Parameter(ParameterSetName = 'IQL')]
        [String]
        $IQL,

        [Parameter(ParameterSetName = 'Generic')]
        [string]
        $DeviceName



    )

    begin {


        Set-StrictMode -Version Latest

        $ErrorActionPreference = 'Stop'
    }

    process {

        try {

            if ($PSBoundParameters.ContainsKey('IQL')) {

                GetInsightObjByIQL -IQL $IQL

            }

                GetInsightObjAttr -DeviceName $DeviceName -TypeID $TypeID


        } catch {

            Write-Error -ErrorAction Continue -Exception $_.Exception

        }



    }

    end {
    }
}