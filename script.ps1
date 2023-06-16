# Function to test connectivity to a virtual machine
function Test-VMConnectivity {
    param (
    [Parameter(Mandatory=$true)]  # Declares the parameter block for the function
    [string]$VMName,              # Represents the name of the virtual machine to test connectivity to

    [Parameter(Mandatory=$true)]  # Declares the second parameter
    [string]$ServiceName          # Represents the service name or IP address to test connectivity to
)
    # Get the virtual machine by name
    $vm = Get-VM -Name $VMName
    if (!$vm) {
        Write-Host "Virtual machine '$VMName' not found."
        return
    }

    # Perform a ping test to the specified service on the virtual machine
    $pingResult = Test-Connection -ComputerName $ServiceName -Count 1 -Quiet

    if ($pingResult) {
        Write-Host "Ping test to '$ServiceName' on virtual machine '$VMName' successful."
    } else {
        Write-Host "Ping test to '$ServiceName' on virtual machine '$VMName' failed."
    }
}

# Test connectivity to CentOS virtual machine
Test-VMConnectivity -VMName "centos" -ServiceName "192.168.0.3"

# Test connectivity to Windows 10 virtual machine
Test-VMConnectivity -VMName "win 10" -ServiceName "192.168.0.4"

# Get switch information
Write-Host "Switches:"
Get-VMSwitch | Format-Table Name, SwitchType

# Get NAT configuration
Write-Host "NAT Configuration:"
Get-NetNat | Format-Table Name, ExternalIPInterfaceAddressPrefix