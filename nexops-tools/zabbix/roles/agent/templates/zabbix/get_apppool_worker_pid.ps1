#Import-Module WebAdministration
param ([string] $name = 0)
$query_processId = gwmi -NS 'root\WebAdministration' -Filter AppPoolName="'$name'" -class 'WorkerProcess'
$processId = ($query_processId).ProcessId
if($query_processId)
{
	$processId = ($query_processId).ProcessId
	$query_WorkingSetPrivate = Get-WmiObject -class Win32_PerfFormattedData_PerfProc_Process | where{$_.idprocess -eq $processId}
	$W3WP1 = $query_WorkingSetPrivate.Name
	$W3WP2 = $W3WP1 -replace "w3wp",""
	if($W3WP2)
	{
		$W3WP = $W3WP2 -replace "#",""
		Write-Output $W3WP
	}else
	{
		Write-Output 0
	}
	
}else
{
	Write-Output "-1"
}