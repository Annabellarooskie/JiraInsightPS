function Get-InsightObject {

    [CmdletBinding()]
    param (

        [Parameter(ParameterSetName = 'TypeID')]
        [String]
        $TypeId,

        [Parameter(ParameterSetName = 'JQL')]
        [String]
        $IQL,

        [Parameter(ParameterSetName = 'ObjectID')]
        [string]
        $Name



    )

    begin {



    }

    process {

        try {

            switch ($PSCmdlet.ParameterSetName) {

                TypeId {

                    GetInsightObjectByTypeID -TypeID $TypeId


                }
                ObjectId {

                    GetInsightObjByName -Name $Name
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