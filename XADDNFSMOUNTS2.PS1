param(
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$DNSHostName
    )

$OMNIDS  = get-cluster PROD_DR| Get-Datastore | where {$_.Type -eq "nfs" -and $_.Accessible -eq "true"}

foreach ($datastore in $OMNIDS) {
 New-Datastore -vmhost $DNSHostName -Nfs -Name $datastore.Name -Path $datastore.RemotePath -NfsHost $datastore.RemoteHost
}



