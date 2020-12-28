param(
[Parameter(Mandatory=$true, Position=0)]
[string] $skypeid
)
Function Convert-BytesToSize
{
#Requires -version 2.0
[CmdletBinding()]
Param
(
[parameter(Mandatory=$False,Position=0)][int64]$Size

)
#Decide what is the type of size
Switch ($Size)
{
{$Size -gt 1PB}
{
Write-Verbose "Convert to PB"
$NewSize = "$([math]::Round(($Size / 1PB),2))PB"
Break
}
{$Size -gt 1TB}
{
Write-Verbose "Convert to TB"
$NewSize = "$([math]::Round(($Size / 1TB),2))TB"
Break
}
{$Size -gt 1GB}
{
Write-Verbose "Convert to GB"
$NewSize = "$([math]::Round(($Size / 1GB),2))GB"
Break
}
{$Size -gt 1MB}
{
Write-Verbose "Convert to MB"
$NewSize = "$([math]::Round(($Size / 1MB),2))MB"
Break
}
{$Size -gt 1KB}
{
Write-Verbose "Convert to KB"
$NewSize = "$([math]::Round(($Size / 1KB),2))KB"
Break
}
Default
{
Write-Verbose "Convert to Bytes"
$NewSize = "$([math]::Round($Size,2))Bytes"
Break
}
}
Return $NewSize

}
$properties=@(
    @{Name="Name"; Expression = {$_.name}},
    @{Name="CPU"; Expression = {[Decimal]::Round(($_.PercentProcessorTime / $CpuCores), 0)}},
    @{Name="Memory"; Expression = {[Math]::Round(($_.workingSetPrivate),0)}}
)
$IPv4 = $(ipconfig | where {$_ -match 'IPv4.+\s(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' } | out-null; $Matches[1])
$CpuCores = (Get-WMIObject Win32_ComputerSystem).NumberOfLogicalProcessors # core CPU
#$top_procs = get-wmiobject WIN32_PROCESS | Sort-Object -Property cpu -Descending|select -first 5|Select @{Name="ProcessID";Expression={[String]$_.ProcessID}},@{Name="UserID";Expression={$_.getowner().user}}
$top_procs = get-wmiobject WIN32_PROCESS | Sort-Object -Property ws -Descending|select -first 10|Select @{Name="ProcessID";Expression={[String]$_.ProcessID}}
$time = $(Get-Date)
$skype_send = "
Top 10 Memory usage on $IPv4
"
$line_send = "
Top 10 Memory usage on $IPv4
"
for($i=0;$i -lt $top_procs.length;$i++)
{
	#$top_procs[$i]
	$number = $i + 1
	$ID_pro = $top_procs[$i]
	$ID_pro = $ID_pro -replace "ProcessID",""
	$ID_pro = $ID_pro -replace '["@{#?\}=]',''
	$User = get-wmiobject WIN32_PROCESS -Filter ProcessId="$ID_pro" |Select @{Name="UserID";Expression={$_.getowner().user}}
	$User = $User -replace "UserID",""
	$User = $User -replace '["@{#?\}=]',''
	$summary = Get-WmiObject -class Win32_PerfFormattedData_PerfProc_Process -filter IDProcess="$ID_pro" | Select-Object $properties #| Format-Table -AutoSize
	$process_name = ($summary).Name
	#$process_name
	$process_cpu = ($summary).CPU
	$process_ram = ($summary).Memory
	$process_ram = Convert-BytesToSize $process_ram
	#($summary).Process Name
	$skype_send += "
	$number. $process_name (by $User)
	CPU: $process_cpu%  Memory: $process_ram
	"
}
$mess_send = $skype_send -replace '["@{#?\}=]',''
$API = "22112018"
Invoke-RestMethod "http://10.40.40.135:7979/bot_api_skype.php?message=$mess_send&API=$API&skypeid=$skypeid"