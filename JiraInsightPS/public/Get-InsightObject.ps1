function Get-InsightObject {

    [CmdletBinding()]
    param (

        [Parameter(ParameterSetName = 'TypeID')]
        [String]
        $TypeId,

        [Parameter(ParameterSetName = 'IQL')]
        [String]
        $IQL,

        [Parameter(ParameterSetName = 'DeviceName')]
        [string]
        $DeviceName



    )

    begin {



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
                Default { }
            }


        } catch {

            Write-Error -ErrorAction Continue -Exception $_.Exception

        }



    }

    end {
    }
}