# 🔄 Auto Live Refresh for OBS Browser Source

**Auto Live Refresh** is a Lua script for [OBS Studio](https://obsproject.com/) that automatically refreshes a selected **Browser Source** whenever you start streaming.

This is useful for reloading dashboards, overlays, widgets, or remote pages to ensure they always load fresh when you go live.

---

## 📥 Installation

1. **Download** the [`auto-live-refresh.lua`](./auto-live-refresh.lua) file from this repository.

2. Open **OBS Studio**.

3. Go to **Tools → Scripts**.

4. Click the ➕ (plus) icon next to **Loaded Scripts**.

5. Select the `auto-live-refresh.lua` file.

6. Under the script’s settings panel (right side), choose the **Browser Source** you want to auto-refresh when streaming starts.

---

## ⚙️ How It Works

- Hooks into the OBS **Start Streaming** event.
- When triggered, it automatically runs OBS's internal **"Refresh cache of current page"** for the selected browser source.
- Only one browser source is affected (the one you select in the dropdown).

---

## ✅ Use Cases

- Refresh Twitch / YouTube widgets or overlays that can stall between streams.
- Reload dashboards or stats pages that need a clean load each session.
- Force load updates for HTML-based stream assets.

---

## 📝 Notes

- Only affects **browser sources**.
- Works with both **local files** and **remote URLs** in browser sources.
