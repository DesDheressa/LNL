# Create session to the host and enter it (commands will be run on remote host)
#$Cred = Get-Credential
$RemoteHost = 'CSHSMGT'
$Session = New-PSSession -ComputerName $RemoteHost #-Credential $Cred
Enter-PSSession $Session

# Declare remote credential. Pass DOMAIN\USERNAME
$RemoteCred = Get-Credential

#Import module1
Import-Module dbatools

#connect to the instance. Changed -sqlCredential to credential
Connect-dbainstance -sqlinstance CVTC14 -credential $RemoteCred
$target = Connect-dbainstance -sqlinstance CVTC14 -credential $RemoteCred
Get-DbaAgDatabase -SqlInstance $target

# 'sqlCredential' is not supported
Get-DbaAgDatabase -SqlInstance CSHSTESTDB3_1 -sqlcredential $RemoteCred 

#return all job categories
Get-DbaAgentJobCategory -SqlInstance CSHSTESTDB3_1 -Credential $Cred 

#some options
#get log
Get-DbatoolsLog

#get error log
$error[0] | select * #| out-file "\\cherryhealth.net\shares\MIS\DatabaseMaintenance\error_logs.txt" -append;

# Quick overview of commands
Start-Process https://dbatools.io/commands


UPDATE-Module dbatools

# End the session:
Exit-PSSession

# Remove the session from the originating host
Remove-PSSession -Session $Session

# DBHDS stuff
Get-DbaAgentJobCategory -SqlInstance CVTC14