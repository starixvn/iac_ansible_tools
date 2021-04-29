#Author: NEXOPS
# Parameters
# ===========================================================================================
$path = "E:\Services\couchbase"
#Remove-Item $outputPath
$BucketNames = Get-Content "$path\BucketName.txt"
# ===========================================================================================
cd "C:\Program Files\Couchbase\Server\bin"
$API = "22112018"
$skypeid = "1016"
foreach ($BucketName in $BucketNames)
{
Write-Host "================================================================================" 
write-host "Flushing Couchbase Cached for $BucketName ..."  -foregroundcolor "yellow"
.\couchbase-cli.exe bucket-flush -c localhost:8091 --force -u Administrator -p !QAZxdr5 --bucket=$BucketName --enable-flush=1
$info = "[Couchbase] - Flushing Cache for Bucket $BucketName"
$url_skype = "http://10.40.40.135:7979/bot_api_skype.php?message=$info&API=$API&skypeid=$skypeid"
#Invoke-RestMethod $url_skype
write-host "Done Flushed Cache for $BucketName"  -foregroundcolor "green"
Write-Host "================================================================================"
}

$info = "Done NexOps UM task"
$url_skype = "http://10.40.40.135:7979/bot_api_skype.php?message=$info&API=$API&skypeid=$skypeid"
#Invoke-RestMethod $url_skype
write-host "$info"
#pause