$allContainerName = Get-Content "C:\Program Files\Zabbix Agent\docker-stats.txt" | ForEach-Object{(-split $_)[1]} | Select-Object -Skip 1 | ForEach-Object { $_.Replace(($_.Split(".")[-1]),"").TrimEnd(".") }


function processStack_nexcel {
    param (
        $allContainer
    )
    $listContainerNexcelStack = [System.Collections.ArrayList]::new()
    foreach ($container in $allContainer) {
        if ($container.Contains("nexcel")) {
            [void]$listContainerNexcelStack.Add($container)
        }
    }
    return $listContainerNexcelStack
}

$NexcelContainer = processStack_nexcel $allContainerName

$NexcelContainer.count