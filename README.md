#### **Method 1: Assign Static IP via GUI (Ubuntu Desktop)**

1. **Open Network Settings:**
   - Click on the network icon in the top-right corner of the screen.
   - Select "Settings" or "Network Settings."

2. **Select the Network Interface:**
   - In the Network settings window, choose the network interface you want to configure. This could be "Wired" for Ethernet or "Wi-Fi" for wireless connections.
   - Click on the gear icon (⚙️) next to the network you are connected to.

3. **Switch to IPv4 Settings:**
   - In the settings window for your network, go to the "IPv4" tab.

4. **Change the IPv4 Method to Manual:**
   - Under "IPv4 Method," select "Manual."

5. **Enter Static IP Configuration:**
   - Add the following details:
     - **Address:** The static IP address you want to assign (e.g., `192.168.1.100`).
     - **Netmask:** Typically `255.255.255.0`.
     - **Gateway:** The IP address of your router (e.g., `192.168.1.1`).
   - Under "DNS," you can enter your preferred DNS servers (e.g., `8.8.8.8` for Google DNS).

6. **Save the Settings:**
   - Click "Apply" to save the changes.
   - Disconnect and reconnect to the network to apply the new settings.

7. **Verify the Configuration:**
   - Open a terminal (`Ctrl + Alt + T`).
   - Type `ip addr show` or `ifconfig` to verify that the new static IP address is applied.

#### **Method 2: Assign Static IP via Terminal (Netplan)**

This method involves editing the Netplan configuration file, which is the default network configuration tool in Ubuntu 18.04 and later.

1. **Open Terminal:**
   - Press `Ctrl + Alt + T` to open the terminal.

2. **Identify the Network Interface:**
   - Run the following command to list network interfaces:
     
     ```bash
     ip addr show
     ```
   - Look for your network interface name (e.g., `eth0` for wired or `wlan0` for wireless).

3. **Edit the Netplan Configuration File:**
   - Use a text editor like `nano` to open the Netplan configuration file. The file is usually located in `/etc/netplan/`. The filename may vary but typically looks like `01-netcfg.yaml` or similar.
     
     ```bash
     sudo nano /etc/netplan/01-netcfg.yaml
     ```

4. **Modify the Configuration for Static IP:**
   - Replace or add the following configuration:
     
     ```yaml
     network:
       version: 2
       renderer: networkd
       ethernets:
         eth0:
           dhcp4: no
           addresses:
             - 192.168.1.100/24
           gateway4: 192.168.1.1
           nameservers:
             addresses:
               - 8.8.8.8
               - 8.8.4.4
     ```
   - **Explanation:**
     - `eth0`: Replace this with your network interface name.
     - `192.168.1.100/24`: The static IP address with subnet mask.
     - `192.168.1.1`: The gateway (usually the router’s IP).
     - `8.8.8.8, 8.8.4.4`: DNS servers (Google's public DNS).

5. **Apply the Configuration:**
   - Save and close the file (`Ctrl + O`, then `Enter`, and `Ctrl + X` to exit).
   - Apply the changes by running:
     
     ```bash
     sudo netplan apply
     ```

6. **Verify the Static IP Address:**
   - Run the following command to verify that the static IP address is applied:
     
     ```bash
     ip addr show
     ```
   - Look for your interface (`eth0` or `wlan0`) and confirm that the static IP is correctly assigned.

7. **Test the Connection:**
   - Try pinging the gateway or another device on the network to ensure the connection is working:
     
     ```bash
     ping 192.168.1.1
     ```
