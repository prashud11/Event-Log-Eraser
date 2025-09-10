# Get the current time and calculate the time 3 hours ago
$currentTime = Get-Date
$threeHoursAgo = $currentTime.AddHours(-3)

# Get all event logs
$eventLogs = Get-EventLog -LogName *

# Iterate through each event log
foreach ($log in $eventLogs) {
    # Get events older than 3 hours
    $oldEvents = Get-EventLog -LogName $log.LogDisplayName | Where-Object {$_.TimeGenerated -lt $threeHoursAgo}

    # Clear the old events
    if ($oldEvents.Count -gt 0) {
        Write-Host "Clearing old events from $log.LogDisplayName..."
        $oldEvents | ForEach-Object {
            $_.Clear()
        }
    }
}