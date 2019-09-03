function Get-InsightObjectType {

    [CmdletBinding()]
    param (

    )

    process {

        try {


            $ObjectTypes = GetInsightObjTypeMapping

            Write-Output $ObjectTypes

        } catch {

            Write-Error -ErrorAction Continue -Exception $_.Exception

        }


    }


}
