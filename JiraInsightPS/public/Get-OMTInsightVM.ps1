function Get-OMTInsightVM {

    [CmdletBinding()]
    param (

        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [string]
        $VMName

    )

    begin {

        $ErrorActionPreference = "Stop"

    }

    process {

        try {

            $EncodedPassword = ConnectJiraInsight -config $M_config

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

            $attributes = $results.objectEntries.attributes

            $ownerobject = $attributes | where-object { $_.objectTypeAttribute.id -eq 396 }

            $owner = $ownerobject.objectAttributeValues.referencedobject.label

            $name = $results.objectEntries.name

            $domainobject = $attributes | where-object { $_.objectTypeAttribute.id -eq 399 }

            $domain = $domainobject.objectAttributeValues

            $vmuuid = $attributes | where-object { $_.objectTypeAttribute.id -eq 395 }

            $data = [PSCustomObject] [ordered]@{

                ServerName = $name
                Domain     = $domain
                Owner      = $owner
                UUID       = $vmuuid.objectAttributeValues
                VMwareName = $VMName

            }

            write-output $data

        } catch {

            Write-Error -ErrorAction Continue -Exception $_.Exception

        }


    }

    end {
    }
}