<#
.SYNOPSIS
        Use to disconnect all VI-Connections to vCen

.REQUIREMENTS

        Powercli

.CREATOR
    John Braunsdorf

.DATE
    03/15/2020

#>

### Disconnect ALL VI connections
Disconnect-VIServer $global:DefaultVIServers -Force -Confirm:$false
Write-Host "Disconnected All Shell Connections $global:DefaultVIServers" -BackgroundColor Gray -ForegroundColor Green