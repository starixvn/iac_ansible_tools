$resultCommand = Get-Content "C:\Program Files\Zabbix Agent\docker-stats.txt"
function toBytesUnitNetwork {
    param (
        $unitInput
    )
    switch -Regex ($unitInput) {
        "kB" {
            $value = $unitInput -replace "kB",""
            $value = [int]$value * 1024
            return $value
        }
        "MB" {
            $value = $unitInput -replace "MB",""
            $value = [int]$value * 1048576
            return $value
        }
        "GB" {
            $value = $unitInput -replace "GB",""
            $value = [int]$value * 1073741824
            return $value
        }
    } 
}

function getNetworkOutputContainer {
    param (
        $containerName
    )
    $getNetworkOutputContainer = ($resultCommand | Select-String -Pattern $containerName -SimpleMatch | ForEach-Object {(-split $_)[6]} | ForEach-Object { toBytesUnitNetwork $_ } ) 
    return $getNetworkOutputContainer
    
}

$containerName = $args[0]
getNetworkOutputContainer $containerName





