---
description: Repository Information Overview
alwaysApply: true
---

# ProtonVPN Status for i3blocks Information

## Summary
This project provides a Bash script that displays the current status of ProtonVPN in the i3blocks status bar. It shows active/disconnected status, IP address, VPN server name, country flag based on the public exit IP, and checks internet connectivity. The script is designed to be minimal with few dependencies.

## Structure
The repository has a simple structure with a main script file and documentation:
- `protonvpnApp`: The main Bash script that provides the ProtonVPN status functionality
- `README.md`: Documentation with installation and usage instructions
- `LICENSE`: GNU General Public License v2

## Language & Runtime
**Language**: Bash
**Version**: Compatible with standard Bash environments
**Dependencies**: curl, jq, nmcli (NetworkManager CLI)

## Key Features
- Detects active VPN interfaces using NetworkManager CLI
- Reads ProtonVPN logs to extract server information
- Retrieves public IP address using external services
- Determines country code from IP address
- Displays appropriate country flag emoji based on the VPN server location
- Shows connection status in i3blocks status bar

## Installation & Usage
```bash
# Install dependencies
sudo pacman -S curl jq

# Copy script to system path
sudo cp protonvpnApp /usr/local/bin/protonvpn_status.sh
sudo chmod +x /usr/local/bin/protonvpn_status.sh

# Add to i3blocks configuration
# Edit ~/.config/i3/i3blocks.conf and add:
# [protonvpn]
# command=/usr/local/bin/protonvpn_status.sh
# interval=10
# markup=pango

# Reload i3blocks
pkill -SIGUSR1 i3blocks
# Or restart i3WM
i3-msg restart
```

## Implementation Details
The script performs the following operations:
1. Detects active VPN interfaces using `nmcli`
2. Retrieves the public IP address using `ifconfig.me`
3. Gets the country code from the IP using `ipinfo.io`
4. Extracts the ProtonVPN server name from logs at `~/.cache/Proton/VPN/logs/vpn-app.log`
5. Maps country codes to flag emojis
6. Displays the formatted output for i3blocks

## License
This project is licensed under the GNU General Public License v2.0, allowing free use, modification, and distribution under the same license terms.