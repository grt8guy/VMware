<#
.SYNOPSIS
        Simple but affective vCenter \ VI-Connect - also works with direct ESXi connections as long as Shell \ SSH is snabled
        SSH is not required but I do enable it when I am working on a host

.REQUIREMENTS

        PowerCLI is required
                
.CREATOR
    John Braunsdorf

.DATE
    03/15/2020

#>

# Logon User Interface - no pass through is permitted
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
$VC = [Microsoft.VisualBasic.Interaction]::InputBox("Enter IP of vCenter", "Direct vCenter Connect", "Server-IP-Only") 
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
$user = [Microsoft.VisualBasic.Interaction]::InputBox("Enter Admin Account Name", "Direct vCenter Connect", "Admin Account")
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
$PWD = [Microsoft.VisualBasic.Interaction]::InputBox("Enter Admin Password", "Direct vCenter Connect", "Admin Password")
#

# This section can be used as a static, make sure to rem out the above code
<# Data Gathering
$esxi = ""
$User = ""
$PWD = ''
#>

cls

Set-PowerCLIConfiguration -InvalidCertificateAction Ignore -Confirm:$false

Connect-VIServer $esxi -User $User -Password $PWD

# WScript.shell windows popup notification 
$a = new-object -comobject wscript.shell
$b = $a.popup("Now connected to $esxi",2,"Welcome to vCenter")
