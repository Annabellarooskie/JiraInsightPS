function Get-InsightObject {

    [CmdletBinding()]
    param (

        # [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        # [Enum]
        # $ObjectType



    )

    begin {

    }

    process {

        try {

            $EncodedPassword = GetVaultPassword -config $M_config

            $header = @{

                'Content-Type'  = 'application/json'
                "Authorization" = "Basic $($EncodedPassword)"
            }

            $baseuri = $M_config.Connection.ServerConfigurationurl

            $vmobjecturi = "/rest/insight/1.0/object/navlist/iql"

            $resturi = $baseuri + $vmobjecturi

            $payload = [PSCustomObject] [ordered] @{

                objectTypeId      = "19"
                resultsPerPage    = 1
                iql               = "Name = $VMName"
                includeAttributes = $True
                objectSchemaId    = "2"

            }

            $jsonpayload = ConvertTo-Json -InputObject $payload

            $results = Invoke-RestMethod -Method POST -Uri $resturi -headers $header -body $jsonpayload -ErrorAction Stop

            write-output $results

        } catch {

            Write-Error -ErrorAction Continue -Exception $_.Exception

        }


    }

    end {
    }
}