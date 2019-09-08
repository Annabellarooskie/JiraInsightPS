function GetInsightObjByIQL {

    [CmdletBinding()]
    param (

        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [string]
        $IQL

    )

    begin {

        Set-StrictMode -Version Latest

        $ErrorActionPreference = 'Stop'

        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    }

    process {

        try {

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Constructing POST to Insight API"

            $EncodedPassword = GetVaultPassword

            $header = @{

                'Content-Type'  = 'application/json'
                "Authorization" = "Basic $($EncodedPassword)"
            }

            $baseuri = $M_config.Connection.ServerConfigurationurl

            $vmobjecturi = "/rest/insight/1.0/object/navlist/iql"

            $resturi = $baseuri + $vmobjecturi

            $payload = [PSCustomObject] [ordered] @{

                objectTypeId      = $M_config.Connection.ObjectTypeID
                resultsPerPage    = 10000
                iql               = "$IQL"
                includeAttributes = $True
                objectSchemaId    = $M_config.Connection.SchemaID

            }

            $jsonpayload = ConvertTo-Json -InputObject $payload

            Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Retrieving the objects for Jira Insight by IQL"

            $results = Invoke-RestMethod -Method POST -Uri $resturi -headers $header -body $jsonpayload -ErrorAction Stop

            $results.objectEntries | foreach-object {

                $Object = New-Object psobject

                $attributes = $_.attributes

                foreach ($type in $attributes) {

                    $Value = if ($type.objectAttributeValues -ne 0) { Write-Output $type.objectAttributeValues.displayvalue } else { Write-Output $null }

                    $Attribute = $type.objectTypeAttribute.name

                    Add-member -InputObject $Object -NotePropertyName $Attribute -NotePropertyValue $Value

                }

                Write-Output $Object

            }

        } catch {

            Write-Error -ErrorAction Continue -Exception $_.Exception

        }


    }

    end {
    }
}


