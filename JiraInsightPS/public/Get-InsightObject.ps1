<#
.SYNOPSIS
This public cmdlet queries and returns the Jira Insight objects for a Jira Insight Schema and top level ObjectType.
Both of which are defined in the configuration file for the module.

.PARAMETER TypeID
This parameter is used to return all objects of a certain type. It is most often used in conjunction with the Get-InsightObjectType cmdlet.
It is mutually exclusive to the DeviceName parameter.

.PARAMETER DeviceName
This parameter is used to return all objects of a certain name.  This parameter does both exact name and partial matching on the string.  Do not use wildcard characters.
It is mutually exclusive to the DeviceName parameter.


.EXAMPLE
Get-InsightObject -TypeID 32
Get-InsightObject -DeviceName WAPDEVICE-01

.NOTES
The authentication to Jira Insight is managed by the config file for the username, and assumes you have stored the password in the Credential Manager on the Windows System prior
to running the cmdlet.
#>
function Get-InsightObject {

    [CmdletBinding()]
    param (

        [Parameter(ParameterSetName = 'TypeID')]
        [int]
        $TypeId,

        [Parameter(ParameterSetName = 'IQL')]
        [String]
        $IQL,

        [Parameter(ParameterSetName = 'DeviceName')]
        [string]
        $DeviceName



    )

    begin {


        Set-StrictMode -Version Latest

        $ErrorActionPreference = 'Stop'

    }

    process {

        try {

            switch ($PSCmdlet.ParameterSetName) {

                TypeId {

                    GetInsightObjectByTypeID -TypeID $TypeId

                }
                DeviceName {

                    GetInsightObjByName -DeviceName $DeviceName
                }

                IQL {

                    GetInsightObjByIQL -IQL $IQL
                }
                Default { }
            }


        } catch {

            Write-Error -ErrorAction Continue -Exception $_.Exception

        }



    }

    end {
    }
}