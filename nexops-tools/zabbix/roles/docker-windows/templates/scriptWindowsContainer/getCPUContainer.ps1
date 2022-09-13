$resultCommand = Get-Content "C:\Program Files\Zabbix Agent\docker-stats.txt"
$allContainerName = Get-Content "C:\Program Files\Zabbix Agent\docker-stats.txt" | ForEach-Object{(-split $_)[1]} | Select-String -NotMatch "ID"

function getCPUContainerUsage {
    param (
        $containerName
    )
    $getCPUContainer = ($resultCommand | Select-String -Pattern $containerName -SimpleMatch | ForEach-Object{(-split $_)[2]} | ForEach-Object {$_ -replace "%",""} ) 
    return $getCPUContainer
}

$containerName = $args[0]
getCPUContainerUsage $containerName





