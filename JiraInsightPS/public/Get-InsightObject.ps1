function Get-InsightObject {

    [CmdletBinding()]
    param (

    [Parameter()]
    [InsightObjType]
    $ObjectType

    )

    begin {

        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    }

    process {

        try {

            $EncodedPassword = GetVaultPassword

            $header = @{

                'Content-Type'  = 'application/json'
                "Authorization" = "Basic $($EncodedPassword)"
            }

            $baseuri = $M_config.Connection.ServerConfigurationurl

            $vmobjecturi = "/rest/insight/1.0/object/navlist"

            $resturi = $baseuri + $vmobjecturi

            $payload = [PSCustomObject] [ordered] @{

                objectTypeId      = $ObjectType.ID
                resultsPerPage    = 10000
                includeAttributes = $True
                objectSchemaId    = $M_config.Connection.SchemaID

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