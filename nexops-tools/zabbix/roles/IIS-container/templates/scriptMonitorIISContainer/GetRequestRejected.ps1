$containerName = $args[0]
$containerID = Get-Content "C:\Program Files\Zabbix Agent\docker-stats.txt" | Select-String -Pattern $containerName -SimpleMatch | ForEach-Object{(-split $_)[0]}

function getRequestRejected{
    param (
        $containerID
    )
    $counterName = "(Get-Counter '\ASP.NET v4.0.30319\Requests Rejected').CounterSamples.CookedValue"
    $result = docker exec  $containerID  powershell.exe -c $counterName
    return $result
}


getRequestRejected $containerID
