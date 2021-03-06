function GetInsightObjAttrVal {

    [CmdletBinding()]
    param (

        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]
        $DeviceName,

        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [int32]
        $TypeID

    )

    begin {

        Set-StrictMode -Version Latest

        $ErrorActionPreference = 'Stop'

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

            if ((!$DeviceName) -and ($TypeID) ) {

                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Constructing request to Insight API for TypeID Only"

                $vmobjecturi = "/rest/insight/1.0/object/navlist"

                $resturi = $baseuri + $vmobjecturi

                $payload = [PSCustomObject] [ordered] @{

                    objectTypeId      = $TypeID
                    resultsPerPage    = 10000
                    includeAttributes = $True
                    objectSchemaId    = $M_config.Connection.SchemaID

                }
            }

            if (($DeviceName) -and (!$TypeID) ) {

                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Constructing request to Insight API for DeviceName Only"

                $vmobjecturi = "/rest/insight/1.0/object/navlist/iql"

                $resturi = $baseuri + $vmobjecturi

                $payload = [PSCustomObject] [ordered] @{

                    objectTypeId      = $M_config.Connection.ObjectTypeID
                    resultsPerPage    = 10000
                    iql               = "Name LIKE $DeviceName"
                    includeAttributes = $True
                    objectSchemaId    = $M_config.Connection.SchemaID

                }
            }


            if (($DeviceName) -and ($TypeID) ) {

                Write-Verbose "[$($MyInvocation.MyCommand.Name)]: Constructing request to Insight API for DeviceName and TypeID"

                $vmobjecturi = "/rest/insight/1.0/object/navlist/iql"

                $resturi = $baseuri + $vmobjecturi

                $payload = [PSCustomObject] [ordered] @{

                    objectTypeId      = $TypeID
                    resultsPerPage    = 10000
                    iql               = "Name LIKE $DeviceName"
                    includeAttributes = $True
                    objectSchemaId    = $M_config.Connection.SchemaID

                }
            }

            $jsonpayload = ConvertTo-Json -InputObject $payload

            $results = Invoke-RestMethod -Method POST -Uri $resturi -headers $header -body $jsonpayload -ErrorAction Stop

            $results.objectEntries | foreach-object {

                $Object = New-Object psobject

                $attributes = $_.attributes

                foreach ($type in $attributes) {

                    $Value = if ($type.objectAttributeValues -ne 0) { Write-Output $type.objectAttributeValues.displayvalue } else { Write-Output $null }

                    $Attribute = $type.objectTypeAttribute.name

                    Add-member -InputObject $Object -NotePropertyName $Attribute -NotePropertyValue $Value -force

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


