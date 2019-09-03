function GetInsightObjByName {

    [CmdletBinding(ValueFromPipeline=$True)]
    param (

        [SupportsWildcards()]
        [string]
        $Name

    )

    begin {

        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

        $options = [Management.Automation.WildcardOptions]'IgnoreCase,Compiled'

    }

    process {

        try {


            $Object = New-Object -TypeName "System.Collections.Generic.List[PSObject]"

            $EncodedPassword = GetVaultPassword

            $header = @{

                'Content-Type'  = 'application/json'
                "Authorization" = "Basic $($EncodedPassword)"
            }

            $baseuri = $M_config.Connection.ServerConfigurationurl

            $vmobjecturi = "/rest/insight/1.0/object/iql"

            $resturi = $baseuri + $vmobjecturi


            $payload = [PSCustomObject] [ordered] @{

                objectTypeId      = 19
                resultsPerPage    = 10000
                iql               = "Name = $Name"
                includeAttributes = $True
                objectSchemaId    = $M_config.Connection.SchemaID

            }



            $jsonpayload = ConvertTo-Json -InputObject $payload



            $results = Invoke-RestMethod -Method POST -Uri $resturi -headers $header -body $jsonpayload -ErrorAction Stop

           $ObjectAttributes = $results.attributes

           [hashtable]$Attributes = @{

            Attribute = $ObjectAttributes.objectTypeAttribute.Name
            Value = $ObjectAttributes.objectAttributeValues.DisplayValue

           }

            # $data = [PSCustomObject]@{

            #     ObjectLabel      = $result.label
            #     ObjectType       = $result.objectType.Name
            #     ObjectAttributes = $attributes
            # }

            # $Attributes.Add($data)



            Write-Output $Attributes

        } catch {

            Write-Error -ErrorAction Continue -Exception $_.Exception

        }


    }

    end {
    }
}


