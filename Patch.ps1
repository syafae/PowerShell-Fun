

function Get-PatchTuesday {
    [CmdletBinding()]
    param (
        
    )
    
    process {
        $BaseDate = ( Get-Date -Day 12 ).Date
        $PatchTuesday = $BaseDate.AddDays( 2 - [int]$BaseDate.DayOfWeek )
        $PatchTuesday
                
    }
    
}