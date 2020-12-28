#set-executionpolicy unrestricted
Import-Module WebAdministration
$apppool = gwmi -NS 'root\WebAdministration' -class 'WorkerProcess'  | select AppPoolName
$idx = 1
write-host "{"
write-host " `"data`":[`n"
foreach ($currentapppool in $apppool)
{
	$currentapppool1 = $currentapppool -replace "@{AppPoolName=","" 
	$currentapppool2 = $currentapppool1 -replace "}","" 
    if ($idx -lt $apppool.count)
    {
     
        $line= "{ `"{#APPPOOL_WORKER}`" : `"" + $currentapppool2 + "`" },"
        write-host $line
    }
    elseif ($idx -ge $apppool.count)
    {
    $line= "{ `"{#APPPOOL_WORKER}`" : `"" + $currentapppool2 + "`" }"
    write-host $line
    }
    $idx++;
}
write-host
write-host " ]"
write-host "}"
