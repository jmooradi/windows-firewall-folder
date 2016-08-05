# windows-firewall-folder
Powershell script to automatically add all exes in a folder to Windows firewall
```
PS > get-help .\firewall-folder.ps1 -detailed

.SYNOPSIS
    Automatic Directory Firewall
.DESCRIPTION
    Automatically add firewall rules for every exe in a file path
.PARAMETER path
    The path to the directory (defaults to current directory)
.PARAMETER group
    Firewall rule group (defaults to path directory name)
.PARAMETER inbound
    Inbound rule (default)
.PARAMETER outbound
    Outbound rule
.PARAMETER allow
    Allow rule (default)
.PARAMETER block
    Block rule 
.PARAMETER a
    If not set script is run in test mode
.EXAMPLE
    C:\PS> firewall-folder.ps1 -path "C:\Program Files\Program" -in -block
    <Block all inbound connects (test mode)>

    C:\PS> firewall-folder.ps1 -path "C:\Program Files\Program" -in -block -a
    <Block all inbound connects>
.NOTES
    Author: Jason Mooradian
    Date:   August 04, 2016   
```
