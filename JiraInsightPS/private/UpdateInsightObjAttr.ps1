function UpdateInsightObjAttr {

    [CmdletBinding()]
    param (

    # Objects from Insight
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
    [PSCustomObject]
    $InsightObject,

    # Attribute to update
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
    [AttrEnum]
    $Attribute,

    # New Attribute Value
    [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
    [String]
    $Value

    )

    begin {





    }

    process {

    #    $test = [Enum]::GetNames( [AttrEnum])

    Write-Output $test




    }

    end {

    }
}