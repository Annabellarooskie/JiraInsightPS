function GetAttrEnumList {

try{
        $ObjecTypes = GetInsightObjTypeMapping

        $EnumList = $ObjecTypes.ObjectTypeName

Add-Type -ErrorAction SilentlyContinue -TypeDefinition @"

public enum AttrEnum
        {
           `n$(foreach ($Attr in $EnumList){"`$Attr`,"})`n
}
"@

}
catch {

    Write-Verbose 1

}
}