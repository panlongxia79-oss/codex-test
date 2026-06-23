# Jinher OS V1

穩定預覽入口：

- `http://127.0.0.1:8787/jinher-os-v1/`

這個網址走 `launchd` 常駐的 workspace preview service，不依賴互動 session。

管理指令：

```bash
cd /Users/joeoa/.openclaw/workspace
./scripts/workspace_preview_ctl.sh status
./scripts/workspace_preview_ctl.sh restart
./scripts/workspace_preview_ctl.sh open
```

注意：

- 不要再用 `python3 -m http.server 3456`
- `3456` 保留給 `openclaw-claude-bridge`

上線前：

1. 先更新 Google 商家靜態快照

```bash
cd /Users/joeoa/.openclaw/workspace
python3 scripts/export_jinher_os_google_snapshot.py
```

2. 確認這個檔案存在

```bash
ls jinher-os-v1/google-review-export.json
```

3. 直接把 `jinher-os-v1/` 整個資料夾部署到任一靜態主機

- Vercel：把 project root 指到 `jinher-os-v1/`
- Cloudflare Pages：把 root directory 指到 `jinher-os-v1/`
- Netlify：publish directory 指到 `jinher-os-v1/`

目前 `index.html` 會優先讀 `./google-review-export.json`，只有在本機 preview 才會 fallback 到 `/__api/google-review-export`。
