#!/bin/bash

# Function to check if root privileges are available
function check_root() {
  if [[ $EUID -ne 0 ]]; then
    echo "This script requires root privileges. Please run as root."
    exit 1
  fi
}

# Install Deps
sudo apt update
sudo apt install isc-dhcp-client
sudo sysctl net.ipv4.llmnr_multicast

# Check for root privileges
check_root

# Get the primary interface
interface=$(ip route get 8.8.8.8 | awk '{print $5}' | cut -d':' -f1)

echo "Renewing IP address for interface: $interface" 

# Release and renew IP address
echo "Releasing current IP address..."
sudo dhclient -r $interface
echo "Releasing complete."

echo "Requesting new IP address..."
sudo dhclient $interface

# Check for errors
if [[ $? -ne 0 ]]; then
  echo "Error: Failed to renew IP address."
  exit 1
fi

# Get the new IP address
new_ip=$(ip addr show dev $interface | awk '/inet / {print $2}' | cut -d/ -f1)

# Display success message with new IP
echo "IP address renewed successfully. New IP address: $new_ip"