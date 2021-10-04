#Import-Module WebAdministration
param ([string] $name = 0)
#$name = "Rome.Alpha.Site17"
#$apppool = Get-Content "D:\NexOps\Services\zabbix_agent\listpool.txt"
$data_sender = "E:\NexOps\Services\zabbix_agent\zabbix_sender.exe"
#$computers = Get-Content "E:\NexOps\Tasks\hwinfo\listip.txt"
$zabbix_server = "10.99.99.66"
$realhostname = (gwmi win32_operatingsystem).csname
$apppool = gwmi -NS 'root\WebAdministration' -class 'WorkerProcess'  | select AppPoolName
foreach ($currentapppool in $apppool)
{
$currentapppool1 = $currentapppool -replace "@{AppPoolName=","" 
$currentapppool2 = $currentapppool1 -replace "}","" 
$query_processId = gwmi -NS 'root\WebAdministration' -Filter AppPoolName="'$currentapppool2'" -class 'WorkerProcess' #Rome.Alpha.Site17
$processId = ($query_processId).ProcessId
$cpuCores = (Get-WmiObject -Class Win32_ComputerSystem).NumberofLogicalProcessors
#$cpuCores
# Get the path for the performance counter of the process ID/app pool
$processPath = ((Get-Counter -Counter "\Process(*)\ID Process"  -ErrorAction SilentlyContinue ).CounterSamples | Where-Object {$_.RawValue -eq $processId}).Path.Replace("\id process","\% Processor Time")
#$processPath
# Calculate the percent CPU usage
$cpu = [Math]::Round(((Get-Counter -Counter $processPath).CounterSamples.CookedValue) / $cpuCores)
Write-Output $cpu
& "$data_sender" -z $zabbix_server -s $realhostname -k "apppool_cpu[$currentapppool2]" -o $cpu

Write-Output "& $data_sender -z $zabbix_server -s $realhostname -k apppool_cpu[$currentapppool2] -o $cpu"
}