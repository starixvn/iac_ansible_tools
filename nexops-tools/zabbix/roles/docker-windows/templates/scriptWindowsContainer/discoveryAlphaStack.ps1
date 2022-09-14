$allContainerName = Get-Content "C:\Program Files\Zabbix Agent\docker-stats.txt" | ForEach-Object{(-split $_)[1]} | Select-Object -Skip 1 | ForEach-Object { $_.Replace(($_.Split(".")[-1]),"").TrimEnd(".") }


function processStack_alpha {
    param (
        $allContainer
    )
    $listContainerAlphaStack = [System.Collections.ArrayList]::new()
    foreach ($container in $allContainer) {
        if ($container.Contains("alpha")) {
            [void]$listContainerAlphaStack.Add($container)
        }
    }
    $jsonStackName_alpha = ($listContainerAlphaStack | Select-Object @{Name='{#ALPHA_STACK}'; Expression={$_}} )
    return $jsonStackName_alpha
}

$dataStackNameAlpha = processStack_alpha $allContainerName 


$jsonData = @{
    "data" = @(
        $dataStackNameAlpha
    )
}

$jsonData | ConvertTo-Json




