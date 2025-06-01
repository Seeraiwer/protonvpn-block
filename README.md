# 🌍 ProtonVPN Status for i3blocks

This script displays the **current status of ProtonVPN** in your **i3blocks bar**, including:

- ✅ Active/disconnected detection  
- 🌐 IP address and VPN server name  
- 🏳️ Country flag based on public exit IP  
- 🛜 Internet connectivity check  
- 💥 Minimal dependencies  

---

## 🛠 Installation

### 1️⃣ Clone the repository
```bash
git clone https://github.com/your-username/protonvpn-status.git
cd protonvpn-status
```

### 2️⃣ Install required tools
Make sure you have the following dependencies installed:
```bash
sudo pacman -S curl jq
```

### 3️⃣ Copy the script to your system path
```bash
sudo cp protonvpn_status.sh /usr/local/bin/protonvpn_status.sh
sudo chmod +x /usr/local/bin/protonvpn_status.sh
```

### 4️⃣ Add it to i3blocks
Edit your `~/.config/i3/i3blocks.conf` and add:
```ini
[protonvpn]
command=/usr/local/bin/protonvpn_status.sh
interval=10
markup=pango
```

> 💡 Ensure your i3bar font supports emojis, for example:
> `font pango: Noto Sans Regular 10, Noto Color Emoji 10`

### 5️⃣ Reload i3blocks
```bash
pkill -SIGUSR1 i3blocks
```
Or restart i3WM:
```bash
i3-msg restart
```

---

## 📊 What It Shows

- 🏳️ Country flag based on the public VPN IP (via `ipinfo.io`)
- 🧭 Server name (from ProtonVPN logs)
- 🌐 Exit IP address

### Example output:
```
🇨🇭 node-ch-14 (185.45.56.92)
```

### Disconnected:
```
⚠️ No VPN ⚠️
```

---

## 🔍 How It Works

1. Detects the active VPN interface using `nmcli`.
2. Reads ProtonVPN logs from:
   ```
   ~/.cache/Proton/VPN/logs/vpn-app.log
   ```
3. Extracts the server name and local/public IPs.
4. Queries `https://ipinfo.io/<ip>/country` for the country code.
5. Displays the corresponding country flag and server name.

---

## ✅ Supported Country Flags

| Country        | Code | Flag |
|----------------|------|------|
| France         | FR   | 🇫🇷  |
| Switzerland    | CH   | 🇨🇭  |
| United States  | US   | 🇺🇸  |
| Germany        | DE   | 🇩🇪  |
| United Kingdom | GB   | 🇬🇧  |
| Netherlands    | NL   | 🇳🇱  |
| Sweden         | SE   | 🇸🇪  |
| Canada         | CA   | 🇨🇦  |
| Spain          | ES   | 🇪🇸  |
| Italy          | IT   | 🇮🇹  |
| Unknown        | —    | 🏳️  |

> 🎯 You can add more flags in the `get_flag()` function of the script.


