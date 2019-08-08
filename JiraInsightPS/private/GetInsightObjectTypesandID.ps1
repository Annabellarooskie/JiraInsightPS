function GetInsightObjectTypesandID {

    [CmdletBinding()]
    param (

        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName, Mandatory)]
        [string]
        $Schema

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

            $vmobjecturi = "/rest/insight/1.0/objectschema/" + $Schema + "/objecttypes/flat"

            $resturi = $baseuri + $vmobjecturi

            $results = Invoke-RestMethod -Method GET -Uri $resturi -headers $header -ErrorAction Stop


            $data = [PSCustomObject] [ordered]@{

                ObjectTypetName = $results.name
                ObjectTypeID = $results.id
            }

            Write-Output $data

        } catch {

            Write-Error -ErrorAction Continue -Exception $_.Exception

        }


    }

    end {
    }
}