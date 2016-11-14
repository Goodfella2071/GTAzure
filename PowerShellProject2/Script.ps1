#
# Script.ps1
#
#To login to classic
Add-AzureAccount
#To login to ARM
Login-AzureRmAccount
#To list ARM VMs
Get-AzureRMVM
#To list ARM RGs
Get-AzureRmResourceGroup


Get-Command *azurermbackup*

$joblist = Get-AzureRmBackupJob GT-PROD-RSV-01 $backupvault -Status InProgress
$joblist[0]

$backupvault GT-PROD-RSV-01
$joblist = Get-AzureRmBackupJob -Vault GT-PROD-RSV-01 $backupvault -Status InProgress
$joblist[0]

Get-Help Get-AzureRmBackupJob -Examples

$Vault = Get-AzureRmBackupVault -Name "GT-PROD-RSV-01"
Get-AzureRmBackupJob -Vault $Vault

Get-Help *Get-azurermrecover*
Get-AzureRmBackupContainer
get-help Get-AzureRmRecoveryServicesVault -Examples
Get-AzureRmBackupVault -Name "GT-PROD-RSV-01"
get-help Get-AzureRmVM 
get-azurermvm | Select-Object Extensions,Name

Get-AzureRmRecoveryServicesBackupProtectionPolicy -WorkloadType AzureVM

Get-AzureRmContext
Get-AzureRmSubscription


$RGs = Get-AzureRMResourceGroup
foreach($RG in $RGs)
{
    $VMs = Get-AzureRmVM -ResourceGroupName $RG.ResourceGroupName
    foreach($VM in $VMs)
    {
        $VMDetail = Get-AzureRmVM -ResourceGroupName $RG.ResourceGroupName -Name $VM.Name -Status
        foreach ($VMStatus in $VMDetail.Statuses)
        { 
            if($VMStatus.Code.CompareTo("PowerState/deallocated") -eq 0)
            {
                $VMStatusDetail = $VMStatus.DisplayStatus
            }
        }
        write-output $VM.Name $VMStatusDetail
    }
}

Get-AzureRmVM | Select-Object Name,Extensions




$rgName = "PROD-APPS"
$vmName = "AZNUIXSRV01"
Get-AzureRmVM -ResourceGroupName $rgName -Name $vmName | Select-Object Name,Extensions -

Get-Help Get-AzureRmVM


$PSVersionTable.PSVersion


Get-AzureRmVM -Name AZNUIXSRV01 | Select-Object VirtualMachineExtensionType
Get-AzureRmResourceGroup
get-azurermvm


Get-AzureRmRecoveryServicesBackupItem
Get-AzureRmRecoveryServicesBackupJob

# Solution from Lee Chambers
$vault = Get-AzureRmRecoveryServicesVault -Name "GT-PROD-RSV-01"
Set-AzureRmRecoveryServicesVaultContext -Vault $vault
$backedup = Get-AzureRmRecoveryServicesBackupContainer -ContainerType AzureVM -BackupManagementType AzureVM |ft FriendlyName,ResourceGroupName > C:\Temp\backupvms.csv
$allvms = Get-AzureRmVM | ft Name,ResourceGroupName > C:\Temp\allvms.csv

# How to move resources to different resource groups
$resource = Get-AzureRmResource -ResourceName AZMGT01 -ResourceGroupName Prod-Citrix
Move-AzureRmResource -DestinationResourceGroupName Prod-Infra -ResourceId $resource.ResourceId

Get-AzureRmVM | Select-Object Name,Statuses


