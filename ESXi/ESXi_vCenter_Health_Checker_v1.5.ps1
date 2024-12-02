<#
.SYNOPSIS
        Check vCenter Resources
        
.REQUIREMENTS
        PowerCLI, assuming Broadcom \ VMware PowerCLI is already installed
                
.CREATOR
    John Braunsdorf

.DATE
    03/15/2020
#>

# Data Gathering
$ESXiHost=''
$User=''
$PWD=''
$OutFile='C:\Temp\Audits\vCenter_Health_Checker_Logs\vCenterHC_v2.csv'

Connect-VIServer "$ESXiHost" -User $User -Password $PWD -WarningAction SilentlyContinue

$VmInfo = ForEach ($Datacenter in (Get-Datacenter | Sort-Object -Property Name)) {
  ForEach ($Cluster in ($Datacenter | Get-Cluster | Sort-Object -Property Name)) {
    ForEach ($VM in ($Cluster | Get-VM | Sort-Object -Property Name)) {
      ForEach ($HardDisk in ($VM | Get-HardDisk | Sort-Object -Property Name)) {
        "" | Select-Object -Property @{N="VM";E={$VM.Name}},
        @{N="VM CPU#";E={$vm.ExtensionData.Config.Hardware.NumCPU/$vm.ExtensionData.Config.Hardware.NumCoresPerSocket}},
        @{N="VM CPU Core#";E={$vm.NumCPU}},
        @{N="Datacenter";E={$Datacenter.name}},
        @{N="Cluster";E={$Cluster.Name}},
        @{N="Host";E={$vm.VMHost.Name}},
        @{N="Host CPU#";E={$vm.VMHost.ExtensionData.Summary.Hardware.NumCpuPkgs}},
        @{N="Host CPU Core#";E={$vm.VMHost.ExtensionData.Summary.Hardware.NumCpuCores/$vm.VMHost.ExtensionData.Summary.Hardware.NumCpuPkgs}},
        @{N="Hard Disk";E={$HardDisk.Name}},
        @{N="Datastore";E={$HardDisk.FileName.Split("]")[0].TrimStart("[")}},
        @{N="VMConfigFile";E={$VM.ExtensionData.Config.Files.VmPathName}},
        @{N="VMDKpath";E={$HardDisk.FileName}},
        @{N="VMDK Size";E={($vm.extensiondata.layoutex.file|?{$_.name -contains $harddisk.filename.replace(".","-flat.")}).size/1GB}},
        @{N="Drive Size";E={$HardDisk.CapacityGB}}
      }
    }
  }
}
$VmInfo | Export-Csv -NoTypeInformation -UseCulture -Path $OutFile

### Disconnect ALL VI connections
Disconnect-VIServer $global:DefaultVIServers -Force -Confirm:$false
Write-Host "Disconnected All Shell Connections $global:DefaultVIServers" -BackgroundColor Gray -ForegroundColor Green
