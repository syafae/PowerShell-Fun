<#
The Chairman would like a tool that he can use to query a Windows-based server to discover
the following information:
    When was a server last shutdown?
    When did the server start up again?
    How long was it down?
    What is the current uptime?
The output should include :
    computername
    account intiated the the sutdown or reboot
#>
function Get-UpDownTime {
    [CmdletBinding()]

    param (
        [parameter(ValueFromPipeline)]
        [string[]]$Computername = $env:COMPUTERNAME 
    )
    $lastShutdown = Get-WinEvent -ComputerName $Computername -FilterXPath '*[System[(EventID=1074)]]' -LogName "System" -MaxEvents 1
    $whenDown = $lastShutdown.TimeCreated
    $lastBootTime = Get-CimInstance Win32_OperatingSystem -ComputerName $Computername | Select-Object LastBootUpTime
    $uptime = (Get-Date).Subtract($lastBootTime.LastBootUpTime)
    $downtime = $lastBootTime.LastBootUpTime.Subtract($whenDown)
    $matched = $lastShutdown.Message -match 'user\s+(?<account>.*)\sfor'
    if ($matched) {

        $userInitiatedtheshoutdown = $Matches.account 
    }
    else {
        $userInitiatedtheshoutdown = ""
    }

    [PSCustomObject]@{
        LastShutdown = $whenDown
        LastBootTime = $lastBootTime.LastBootUpTime
        UpTime       = $uptime
        DownTime     = $downtime
        User         = $userInitiatedtheshoutdown
    }
}