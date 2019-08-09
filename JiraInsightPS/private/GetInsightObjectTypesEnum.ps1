function GetInsightObjectTypesEnum {

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

                $ObjectTypes = New-Object -TypeName "System.Collections.Generic.List[PSObject]"

                $EncodedPassword = ConnectJiraInsight -config $M_config

                $header = @{

                    'Content-Type'  = 'application/json'
                    "Authorization" = "Basic $($EncodedPassword)"
                }

                $baseuri = $M_config.Connection.ServerConfigurationurl

                $vmobjecturi = "/rest/insight/1.0/objectschema/" + $Schema + "/objecttypes/flat"

                $resturi = $baseuri + $vmobjecturi

                $results = Invoke-RestMethod -Method GET -Uri $resturi -headers $header -ErrorAction Stop

                foreach ($type in $results) {

                $data = [PSCustomObject]@{

                    ObjectTypeName = $type.name
                    ObjectTypeID   = $type.id
                }

                $ObjectTypes.Add($data)



            }

            Write-Output $ObjectTypes

            } catch {

                Write-Error -ErrorAction Continue -Exception $_.Exception

            }


        }

        end {
        }
    }
