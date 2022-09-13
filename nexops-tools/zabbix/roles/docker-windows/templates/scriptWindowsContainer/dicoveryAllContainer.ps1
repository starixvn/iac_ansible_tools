$allContainerName = Get-Content "C:\Program Files\Zabbix Agent\docker-stats.txt" | ForEach-Object{(-split $_)[1]} | Select-Object -Skip 1 | ForEach-Object { $_.Replace(($_.Split(".")[-1]),"").TrimEnd(".") }


$json = ($allContainerName | Select @{Name='{#NAME_CONTAINER}'; Expression={$_}} | ConvertTo-Json)
$json