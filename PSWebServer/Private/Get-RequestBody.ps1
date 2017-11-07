function Get-RequestBody {
    
    param(
        [String]$ContentType,
        [System.Text.Encoding]$ContentEncoding,
        [System.IO.Stream]$Body
    )

    $StreamReader = [System.IO.StreamReader]::new($Body)
    $BodyContents = $StreamReader.ReadToEnd()
    $null = New-Event -SourceIdentifier ConsoleMessageEvents -MessageData "ContentType: $ContentType"
    $null = New-Event -SourceIdentifier ConsoleMessageEvents -MessageData "BodyContents: $BodyContents"

    if($ContentType -match "json") {
        $BodyContents = $BodyContents | ConvertFrom-Json
    }elseif($ContentType -match "x-www-form-urlencoded") { 
        $QueryStringCollection = [System.Web.HttpUtility]::ParseQueryString($BodyContents)
        $null = New-Event -SourceIdentifier ConsoleMessageEvents -MessageData ($QueryStringCollection)
        $BodyContentsHash = [hashtable]@{}
        $QueryStringCollection.AllKeys | foreach { $BodyContentsHash[$_] = $QueryStringCollection[$_] }
        $BodyContents = New-Object -TypeName psobject -Property $BodyContentsHash
    }

    return $BodyContents
}
