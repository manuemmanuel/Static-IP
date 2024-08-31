#!/bin/bash

INTERFACE="eth0"
STATIC_IP="192.168.1.100/24" 
GATEWAY="192.168.1.1"
DNS_SERVERS="8.8.8.8, 8.8.4.4"

if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

NETPLAN_DIR="/etc/netplan"
BACKUP_DIR="$NETPLAN_DIR/backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"
cp $NETPLAN_DIR/*.yaml "$BACKUP_DIR"

echo "Backup of current Netplan configurations saved in: $BACKUP_DIR"

NETPLAN_FILE="$NETPLAN_DIR/01-static-ip-config.yaml"
echo "Creating Netplan configuration file at $NETPLAN_FILE..."

cat <<EOL > $NETPLAN_FILE
network:
  version: 2
  renderer: networkd
  ethernets:
    $INTERFACE:
      dhcp4: no
      addresses:
        - $STATIC_IP
      gateway4: $GATEWAY
      nameservers:
        addresses:
          - ${DNS_SERVERS//, /,}
EOL

# Apply the Netplan configuration
echo "Applying Netplan configuration..."
sudo netplan apply

# Verify the new IP configuration
echo "New network configuration:"
ip addr show $INTERFACE

echo "Static IP configuration applied successfully."
