#!/bin/bash
NETPLAN_CONFIG="/etc/netplan/01-netcfg.yaml"
sudo cp $NETPLAN_CONFIG "$NETPLAN_CONFIG.bak"
sudo tee $NETPLAN_CONFIG > /dev/null <<EOL
network:
  version: 2
  renderer: networkd
  ethernets:
    enp1s0:
      addresses:
        - 192.168.1.100/24
      nameservers:
        addresses: [192.168.1.1, 1.1.1.1]
      routes:
        - to: default
          via: 192.168.1.1
EOL

sudo netplan apply

echo "Static IP configuration applied successfully."
