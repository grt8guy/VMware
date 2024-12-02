<#
.SYNOPSIS
        Use to disconnect all VI-Connections to vCen

.REQUIREMENTS

        PowerCLI, assuming Broadcom \ VMware PowerCLI is already installed

.CREATOR
    John Braunsdorf

.DATE
    03/15/2020

#>

### Disconnect ALL VI connections
Disconnect-VIServer $global:DefaultVIServers -Force -Confirm:$false
Write-Host "Disconnected All Shell Connections $global:DefaultVIServers" -BackgroundColor Gray -ForegroundColor Green
