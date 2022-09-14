$containerName = $args[0]
$containerID = Get-Content "C:\Program Files\Zabbix Agent\docker-stats.txt" | Select-String -Pattern $containerName -SimpleMatch | ForEach-Object{(-split $_)[0]}

function getRequestExcuting{
    param (
        $containerID
    )
    $counterName = "(Get-Counter '\ASP.NET Apps v4.0.30319(__Total__)\Requests Executing').CounterSamples.CookedValue"
    $result = docker exec $containerID  powershell.exe -c $counterName
    return $result
}


getRequestExcuting $containerID
