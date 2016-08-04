<#
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
#>
param([string]$path, [string]$group, [switch]$inbound, [switch]$outbound, [switch]$block, [switch]$allow, [switch]$a)

$NET_FW_RULE_DIR_IN = "1"
$NET_FW_RULE_DIR_OUT = "2"

$NET_FW_ACTION_BLOCK = 0
$NET_FW_ACTION_ALLOW = 1

function Add-FirewallRule {
   param( 
      $name,
      $group,
      $program,
      $direction = $NET_FW_RULE_DIR_IN,
      $allow = $NET_FW_ACTION_ALLOW    
   )

    $fw = New-Object -ComObject hnetcfg.fwpolicy2 
    $rule = New-Object -ComObject HNetCfg.FWRule

    $rule.Name = $name
    $rule.ApplicationName = $program
    $rule.Enabled = $true
    $rule.Grouping = $group
    $rule.Profiles = 7 # all
    $rule.Action = $allow
    $rule.Direction = $direction
    $rule.EdgeTraversal = $false

    $fw.Rules.Add($rule)
}

function Add-FirewallDirectoryRules {
   param( 
      $folder,
      $group,
      $direction = $NET_FW_RULE_DIR_IN,
      $action  = $NET_FW_ACTION_ALLOW
    )

    if (-not $folder) {
        $folder = ".\"
    }

    if (-not $group) {
        $group = (Get-Item -Path $folder).Name
    }

    if ($a -ne $true) {
        Write-Host Test Mode: Run with -a
    }

        
    Write-Host Add Rules: (&{If($action -eq 1) {"Allow"} Else {"Block"}}) (&{If($direction -eq "1") {"Inbound"} Else {"Outbound"}}) Group=$group
    Get-ChildItem -Path $folder -Filter *.exe -Recurse | ForEach {
        $name = $_.Name
        $path = $_.Fullname
        Write-Host Add Rule: Name=`"$name`" Path=`"$path`" 
        if ($a -eq $true) {
            Add-FirewallRule $_.Name $group $_.Fullname $direction $action
        }
    }

    if ($a -eq $true) {
        Write-Host All Rules Added
    }
}

function GetPSCall{
   param($params)

   $arguments = @()
   $arguments += "-NoExit"
   $arguments += $PSCommandPath

   foreach($psbp in $params.GetEnumerator())
   {
       $argument = "-" + $psbp.Key
       if ($psbp.Value -is [string]){
            $argument += " '" + $psbp.Value + "'"
       }

       $arguments += $argument
   }
   return $arguments
}

$direction = $NET_FW_RULE_DIR_IN 
$action = $NET_FW_ACTION_ALLOW

If ($outbound -eq $true) {$direction = $NET_FW_RULE_DIR_OUT}
If ($inbound -eq $true){$direction = $NET_FW_RULE_DIR_IN}

If ($block -eq $true) {$action = $NET_FW_ACTION_BLOCK}
If ($allow -eq $true) {$action = $NET_FW_ACTION_ALLOW}

if ($a -eq $true -and -not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    
    $arguments = GetPSCall $PSBoundParameters

    if (-not $path){
        $arguments += "-path '" + (Get-Item -Path ".\").Fullname + "'"
    }

    Start-Process powershell -Verb runAs -ArgumentList $arguments
    exit
}

Add-FirewallDirectoryRules $path $group $direction $action
