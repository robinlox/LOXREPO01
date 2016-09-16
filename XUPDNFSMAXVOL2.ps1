   param(
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string]$DNSHostName = $Env:COMPUTERNAME
    )
  
Get-AdvancedSetting -Entity (Get-vmhost -Name $DNSHostName) -Name NFS.MaxVolumes | Set-AdvancedSetting -confirm:$false -Value 256

