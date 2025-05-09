# NexusJailing - Staff Jail System

**NexusJailing** is a lightweight and modern **staff jail system** for FiveM. Built with `ox_lib` for a clean and responsive UI, it provides staff with an intuitive way to jail and unjail players with time-based control, MRPD jail positioning, and Discord webhook logging.

---

## 🔧 Features

- 📋 **Simple Staff Jail Command**: `/jail` opens a UI to select:
  - Player ID
  - Jail Time (in minutes)
  - Reason
- 🔓 **Quick Release**: `/unjail [id]` releases jailed players
- ⌛ Time-based jail system
- 📍 Teleports to jail and release positions
- 📤 Discord webhook logging for all jail/unjail actions
- 🔐 **Permission-based Access**: Uses `NexusJailing.Staff`

---

## 📜 Commands

- `/jail`  
  Opens an input menu (via `ox_lib`) to enter:
  - Player ID
  - Jail Time (minutes)
  - Reason for jailing

- `/unjail [id]`  
  Instantly releases the specified player.

> **Note:** Only users with the `NexusJailing.Staff` permission can run these commands.

---

## ⚙️ Configuration

Edit `config.lua` to customize webhook and locations:

```lua
-- config.lua
return {
    webhookURL = "WEBHOOK_HERE",  -- Replace with your actual webhook URL

    jailPos = vector3(459.9, -994.3, 24.91),   -- MRPD jail cell position
    unjailPos = vector3(427.9, -979.5, 30.7),  -- MRPD lobby release position
}
```

🚀 Installation
Clone or download the repository:
```git clone https://github.com/yourusername/NexusJailing.git```
Place the folder into your resources directory.

Add the resource to your server.cfg:
ensure NexusJailing
Update the webhook and positions in config.lua.

✅ Requirements
ox_lib – Required for UI support.

🛡️ Permissions
Only users with the following permission can use the system:

NexusJailing.Staff
Make sure to assign this using your permission framework (e.g. ace, vMenu, or qb-core).

📄 License
This project is licensed under the MIT License.
