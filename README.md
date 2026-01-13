# 🌍 ProtonVPN Status for i3blocks

This script displays the **current status of ProtonVPN** in your **i3blocks bar**, including:

- ✅ Active/disconnected detection  
- 🌐 IP address and VPN server name  
- 🏳️ Country flag based on public exit IP  
- 🧠 Cache to avoid repeated network calls  
- 💥 Minimal dependencies

---

## 🛠 Installation

### 1️⃣ Install required tools
Make sure you have the following dependencies installed:
```bash
sudo pacman -S curl networkmanager
```

### 2️⃣ Copy the script to your system path
```bash
sudo cp protonvpnApp /usr/local/bin/protonvpnApp
sudo chmod +x /usr/local/bin/protonvpnApp
```

### 3️⃣ Add it to i3blocks
Edit your `~/.config/i3/i3blocks.conf` and add:
```ini
[protonvpn]
command=/usr/local/bin/protonvpnApp
interval=10
markup=pango
```

> 💡 Ensure your i3bar font supports emojis, for example:
> `font pango: Noto Sans Regular 10, Noto Color Emoji 10`

### 4️⃣ Reload i3blocks
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
3. Extracts the server name and public IP.
4. Queries `https://ipinfo.io/<ip>/country` for the country code.
5. Displays the corresponding country flag and server name.

---

## ⚙️ Configuration

You can override defaults by creating:
```
~/.config/protonvpn-status/config
```

Example:
```bash
DEBUG_MODE=1
CACHE_TIMEOUT=120
TIMEOUT=3
```

Optional custom flags file:
```
~/.config/protonvpn-status/flags
```
Format:
```
FR:🇫🇷
CH:🇨🇭
```

---

## 🧪 CLI Options

- `--debug` enables logging to `/tmp/protonvpn_debug.log`
- `--clear-cache` removes cached IP/country/server files
- `--help` prints usage

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

---

## 🗂 Notes

- Cache lives in `/tmp/protonvpn_status` (IP, country, server name).
- IPv6 public IPs are supported.
- Tailscale connections are ignored on purpose.

---

## 📜 License

GNU AFFERO GENERAL PUBLIC LICENSE
