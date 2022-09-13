$containerName = $args[0]
$containerID = Get-Content "C:\Program Files\Zabbix Agent\docker-stats.txt" | Select-String -Pattern $containerName -SimpleMatch | ForEach-Object{(-split $_)[0]}

function getCurrentConnection{
    param (
        $containerID
    )
    $counterName = "(Get-Counter '\Web Service(_Total)\Current Connections').CounterSamples.CookedValue"
    $result = docker exec $containerID  powershell.exe -c $counterName
    return $result
}


getCurrentConnection $containerID
