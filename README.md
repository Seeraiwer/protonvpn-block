---

# 🔒 ProtonVPN Status for i3blocks

This script **monitors the connection status of ProtonVPN** and displays relevant information in **i3blocks**.

✔ **Detects active/disconnected VPN status**  
✔ **Displays VPN server name and IP address**  
✔ **Checks internet connectivity**  
✔ **Indicates high latency warnings**  
✔ **Compatible with i3blocks**

---

## 🛠 Installation

### 1️⃣ **Clone the repository**
```bash
git clone https://github.com/your-username/protonvpn-status.git
cd protonvpn-status
```

### 2️⃣ **Install dependencies**
Ensure you have the necessary tools:
```bash
sudo pacman -S jq bc curl
```

### 3️⃣ **Copy the script to `/usr/local/bin/`**
```bash
sudo cp protonvpn_status.sh /usr/local/bin/protonvpn_status.sh
sudo chmod +x /usr/local/bin/protonvpn_status.sh
```

### 4️⃣ **Add to i3blocks**
Edit your `~/.config/i3blocks/config` file and add:
```ini
[protonvpn]
command=/usr/local/bin/protonvpn_status.sh
interval=10
label=🔒
```

### 5️⃣ **Reload i3blocks**
```bash
pkill -SIGUSR1 i3blocks
```
Or restart i3WM:
```bash
i3-msg restart
```

---

## ⚡ Status Indicators

- 🟥 **Red (`#FF0000`)** → VPN is disconnected or unstable.
- 🟨 **Yellow (`#FFFF00`)** → VPN is connecting.
- 🟪 **Purple (`#d335ff`)** → VPN is active and running.
- 🚀 **Displays the server name and IP when connected.**

---

## 🔗 How It Works

1. **Reads ProtonVPN logs** from `$HOME/.cache/Proton/VPN/logs/vpn-app.log`.
2. **Checks the last connection status**:
   - If **disconnected**, it shows `"No VPN"`.
   - If **no valid server info is found**, it shows `"Connecting..."`.
   - Otherwise, it **displays the server name and IP address**.
3. **Performs an internet check** using `ping`.
4. **Detects high latency** (> 100ms) and warns if needed.

---

## 📜 License

This project is licensed under the **MIT License**.  
See the [LICENSE](LICENSE) file for more details.

---

## 🚀 Contributing

Contributions are welcome!  
- Fork the project 🍴  
- Create a branch 🛠️ (`git checkout -b feature-my-new-feature`)  
- Submit a PR 🚀  

---

## 📩 Contact

💬 **Have suggestions or issues?** Open an [Issue](https://github.com/your-username/protonvpn-status/issues)  
