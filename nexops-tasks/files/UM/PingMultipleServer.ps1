### API Notify via Skynex
$API = "22112018"
$skypeid = "19:f96bec7162b343098a14116fb58986b4@thread.skype"
$skypeid_pst = "19:b6e908e254c64b64b38fdce25d2c0250@thread.skype"
#################### Scan Servers after proceeding UM task##############################
Clear-Content temp.txt
$info ="---After proceeding UM task---"
$url_skype = "http://10.40.40.135:7979/bot_api_skype.php?message=$info&API=$API&skypeid=$skypeid"
Invoke-RestMethod $url_skype
    ##
    write-host "$info"	-foregroundcolor "green"
    start-sleep 10
    $isComputerUp = $true
    do{
        $content = get-content content.txt
        $isUp = 1
	    foreach($computer in $content)
	    {
            $except_list = get-content temp.txt
		    if ($computer -notin $except_list)
            {
			    if (Test-Connection -ComputerName $computer -Count 1 -ErrorAction SilentlyContinue)
			    {
				    $info = "$computer -> up"
				    $isComputerUp = $true
                    $color = "green"
                    "$computer" | Add-Content 'temp.txt'
                    #$isUp = 1
			    }
			    else
			    {			
				    $isComputerUp = $false
				    $info = "<b>$computer -> down</b>" 
                    $color = "red"
				    start-sleep 2;
                    $isUp = 0
			    }
			    $url_skype = "http://10.40.40.135:7979/bot_api_skype.php?message=$info&API=$API&skypeid=$skypeid"
			    Write-Host "$info" -foregroundcolor "$color"
                Invoke-RestMethod $url_skype
            }
		
	    }
    ##
        if($isUp -eq 0)
        {
            $isComputerUp = $false
            start-sleep 30
        }
        else
        {
            $isComputerUp = $true
        }
    }while(!$isComputerUp)
####################End Scan Servers after Rebooting##############################