$VMSSRgname = "jaivmss"
$VMSSName = "jaivmss"

$vmssListResult = Get-AzureRmVmssVMList -ResourceGroupName $VMSSRgname -VirtualMachineScaleSetName $VMSSName
$vmlist = $vmssListResult.VirtualMachineScaleSetVMs

$VMSSVMs = for ($i = 0;$i -lt $vmList.count;$i++){write-host $i;Get-AzureRmVmssVM -ResourceGroupName $VMSSRgname -VMScaleSetName $VMSSName -InstanceId $i}

$vmssids = foreach($id in $vmssvms){$id.VirtualMachineScaleSetVM.InstanceId}
$nics = Get-AzureRmNetworkInterface -ResourcegroupName $VMSSRgname -VirtualMachineScaleSetName $VMSSName

$vmssprivipa = $nics.IPConfigurations.PrivateIPAddress

$vmssinsttable = @{}

for($i=0;$i -lt $vmssids.Count;$i++){$vmssInstTable.Add($vmssids[$i],$vmssprivipa[$i])}
$vmssInstTable | sort -Descending -Property Name


Start:  VMSS Capacity = 7
	Instance ID= 0,1,2,3,4,5,6
Mod:  Remove VMSS Instances:  1,2,5
	Instance ID=0,3,4,6  ==> This causes issues with line 7, use get-azurermnetworkinterface instead
Mod:  Update Capacity to 10
	Instance ID=0,3,4,6,7,8,9,10,11,12

Get-AzureRmNetworkInterface -ResourceGroupName jaivmss -VirtualMachineScaleSetName jaivmss