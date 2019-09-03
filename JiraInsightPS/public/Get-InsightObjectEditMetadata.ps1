function Get-InsightObjectEditMetadata  {

    [CmdletBinding(PositionalBinding, ConfirmImpact = 'medium')]

    param (

        [Parameter()]
        [InsightObj]
        $Object


    )

    begin {


        Write-output $object.attributes


    }

    process {

        try {


         } catch {

            Write-Error -ErrorAction Stop -Exception $_.Exception

        }

    }

    end {

    }

}