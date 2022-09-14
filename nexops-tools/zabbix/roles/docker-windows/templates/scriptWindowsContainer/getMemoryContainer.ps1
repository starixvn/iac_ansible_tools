$resultCommand = Get-Content "C:\Program Files\Zabbix Agent\docker-stats.txt"
function toBytesUnitMemory {
    param (
        $unitInput
    )
    switch -Regex ($unitInput) {
        "KiB" {
            $value = $unitInput -replace "KiB",""
            $value = [int]$value * 1024
            return $value
        }
        "MiB" {
            $value = $unitInput -replace "MiB",""
            $value = [int]$value * 1048576
            return $value
        }
        "GiB" {
            $value = $unitInput -replace "GiB",""
            $value = [int]$value * 1073741824
            return $value
        }
    }
    
}

function getMemoryContainerUsage {
    param (
        $containerName
    )
    $getMemoryContainer = ($resultCommand | Select-String -Pattern $containerName -SimpleMatch | ForEach-Object{(-split $_)[3]} | ForEach-Object { toBytesUnitMemory $_ } )
    return $getMemoryContainer
}

$containerName = $args[0]
getMemoryContainerUsage $containerName