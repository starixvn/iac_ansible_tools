Function Start-Countdown 
{
    Param(
        [Int32]$Seconds = 10,
        [string]$Message = "Pausing for 10 seconds..."
    )
    ForEach ($Count in (1..$Seconds))
    {   Write-Progress -Id 1 -Activity $Message -Status "Waiting for $Seconds seconds, $($Seconds - $Count) left" -PercentComplete (($Count / $Seconds) * 100)
        Start-Sleep -Seconds 1
    }
    Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed
}
Invoke-Command -ComputerName GQRH45J flush_cached_couchbase.ps1
write-host "---------------------------------"
write-host "Flushing couchebase cached tasks is finished"
#Start-Countdown -Seconds 120 -Message "HAProxy smoke test is running..."
#.\haproxy_smoketest.ps1
#write-host "---------------------------------"
#write-host "HAProxy smoke test is finished"