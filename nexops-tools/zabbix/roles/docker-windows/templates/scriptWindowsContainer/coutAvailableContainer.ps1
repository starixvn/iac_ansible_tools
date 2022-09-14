$allContainerName = Get-Content "C:\Program Files\Zabbix Agent\docker-stats.txt" | ForEach-Object{(-split $_)[1]} | Select-Object -Skip 1 | ForEach-Object { $_.Replace(($_.Split(".")[-1]),"").TrimEnd(".") }

$allContainerName.Count