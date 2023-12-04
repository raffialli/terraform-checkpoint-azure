# Define your resource group name and VM name.
$resourceGroupName = "VT-resources"
$vmName = "checkpoint-fw"

# Get the network interface associated with the VM
$nic = Get-AzNetworkInterface -ResourceGroupName $resourceGroupName | Where-Object { $_.VirtualMachine.Id -like "*$vmName*" }

# Get the public IP information and format it as a clickable link
if ($nic -and $nic.IpConfigurations[0].PublicIpAddress.Id) {
    $publicIp = Get-AzPublicIpAddress -ResourceGroupName $resourceGroupName | Where-Object { $_.Id -eq $nic.IpConfigurations[0].PublicIpAddress.Id }
    $url = "https://$($publicIp.IpAddress)"
    Write-Output "Public IP URL: $url"
} else {
    Write-Output "No public IP associated with the VM."
}