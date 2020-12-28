#Import-Module WebAdministration
param ([string] $name = 0)
#$query_processId = gwmi -NS 'root\WebAdministration' -Filter AppPoolName="'Olympus.NAP.Settlement.Site'" -class 'WorkerProcess'
$query_processId = gwmi -NS 'root\WebAdministration' -Filter AppPoolName="'$name'" -class 'WorkerProcess'
$processId = ($query_processId).ProcessId
#$processId
$query_WorkingSetPrivate = Get-WmiObject -class Win32_PerfFormattedData_PerfProc_Process | where{$_.idprocess -eq $processId}
$WorkingSetPrivate = ($query_WorkingSetPrivate.WorkingSetPrivate / 1Kb)
Write-Output $WorkingSetPrivate