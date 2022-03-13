Param(
    [datetime] $Today = (Get-Date)
)

$Startofthemonth = $Today.AddDays( - ($Today.Day - 1))
$dayofweek = @{
    Sunday    = 1   
    Monday    = 2   
    Tuesday   = 3
    Wednesday = 4
    Thursday  = 5
    Friday    = 6
    Saturday  = 7
}
$tab = @{
    Saturday  = 10
    Sunday    = 9
    Monday    = 8
    Tuesday   = 7
    Wednesday = 13
    Thursday  = 12
    Friday    = 11
}

$offset = $tab[$Startofthemonth.DayOfWeek.ToString()]
$result = $Startofthemonth.AddDays($offset)
Write-Host "Check Microsoft update and start testing them"
Write-Host $result