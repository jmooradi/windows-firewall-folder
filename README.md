# windows-firewall-folder
Powershell script to automatically add all exes in a folder to Windows firewall
```
PS> get-help .\firewall-folder.ps1

NAME
    C:\Dev\firewall-folder.ps1

SYNOPSIS
    Automatic Directory Firewall


SYNTAX
    C:\Dev\firewall-folder.ps1 [[-path] <String>] [[-group] <String>] [-inbound] [-outbound] [-block] [-allow]
    [-recursive] [-run] [<CommonParameters>]


DESCRIPTION
    Automatically add firewall rules for every exe in a file path


RELATED LINKS

REMARKS
    To see the examples, type: "get-help C:\Dev\firewall-folder.ps1 -examples".
    For more information, type: "get-help C:\Dev\firewall-folder.ps1 -detailed".
    For technical information, type: "get-help C:\Dev\firewall-folder.ps1 -full".



PS C:\Dev> get-help .\firewall-folder.ps1 -detailed

NAME
    C:\Dev\firewall-folder.ps1

SYNOPSIS
    Automatic Directory Firewall


SYNTAX
    C:\Dev\firewall-folder.ps1 [[-path] <String>] [[-group] <String>] [-inbound] [-outbound] [-block] [-allow]
    [-recursive] [-run] [<CommonParameters>]


DESCRIPTION
    Automatically add firewall rules for every exe in a file path


PARAMETERS
    -path <String>
        The path to the directory (defaults to current directory)

    -group <String>
        Firewall rule group (defaults to path directory name)

    -inbound [<SwitchParameter>]
        Inbound rule (default)

    -outbound [<SwitchParameter>]
        Outbound rule

    -block [<SwitchParameter>]
        Block rule

    -allow [<SwitchParameter>]
        Allow rule (default)

    -recursive [<SwitchParameter>]
        If file search is recursive

    -run [<SwitchParameter>]
        If not set script is run in test mode

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

    -------------------------- EXAMPLE 1 --------------------------

    PS>.\firewall-folder.ps1 -path "C:\Program Files\Program" -in -block

    <Block all inbound connects (test mode)>

    PS> .\firewall-folder.ps1 -path "C:\Program Files\Program" -in -block -run
    <Block all inbound connects>

```
