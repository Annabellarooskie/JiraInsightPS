class InsightObj {

    [string]$ObjectLabel
    [int]$ObjectTypeID
    [string]$ObjectType
    [hashtable]$ObjectAttributes
}
{

    InsightObj([Object]$objectID) {

     $this.ObjectLabel = $ObjectID

    }



}