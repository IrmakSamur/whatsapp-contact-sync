# WhatsApp Contact Sync

<p align="center">
    <img src="web/public/logo.png" alt="logo" width="150"/>
</p>

A small self-hosted web app that copies your contacts' **WhatsApp profile pictures into Google Contacts**.\
Contacts are matched by phone number using [whatsapp-web.js](https://github.com/pedroslopez/whatsapp-web.js) and the [Google People API](https://developers.google.com/people).

Everything runs on your own computer: your WhatsApp session and Google login never pass through a third-party server.

## Features

- Scan a QR code to link WhatsApp, sign in with Google, sync
- **Overwrite existing images** (on by default) or keep photos you already set
- **Manual sync**: compare old and new photo per contact and choose
- Handles numbers saved without a country code (uses your own number's country)
- ~1.5 s per photo (Google allows 60 photo updates per minute)

## Requirements

- [Node.js](https://nodejs.org/) (v22 or newer)
- Google Chrome
- A Google Cloud OAuth client (free, one-time setup, see below)

## Setup (once)

### 1. Install

```powershell
git clone https://github.com/IrmakSamur/whatsapp-contact-sync.git
cd whatsapp-contact-sync\server
$env:PUPPETEER_SKIP_DOWNLOAD="true"; npm install
cd ..\web; npm install
```

### 2. Google OAuth client

1. In the [Google Cloud Console](https://console.cloud.google.com), create a project.
2. Enable the **Google People API**.
3. Configure the **OAuth consent screen**: user type *External*, leave it in *Testing*, and add your own Google account as a **test user**.
4. Create an **OAuth client ID** of type *Web application* with this **Authorized redirect URI**:
   `http://localhost:4000/api/google_callback`

### 3. Create `server/.env`

```
GOOGLE_CLIENT_ID=<your client id>.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=<your client secret>
CHROME_PATH=C:\Program Files\Google\Chrome\Application\chrome.exe
```

`server/.env` is git-ignored. Keep a copy of the secret in a password manager.

## Usage

Windows: right-click `start.ps1` → **Run with PowerShell**. It starts the backend (port 8080) and the web app (port 4000) and opens http://localhost:4000.

Then: **Get Started** → scan the QR code (WhatsApp → *Linked devices*) → sign in with Google → choose options → keep the tab open until "Sync complete!". Close the two PowerShell windows when done, and remove the linked device in WhatsApp.

A Dutch step-by-step guide is in [SETUP-NL.md](SETUP-NL.md).

### Manual start (any OS)

```bash
# backend (needs the variables from server/.env in the environment)
cd server && npx ts-node --transpile-only .
# web app
cd web && npm run dev
```

## Troubleshooting

WhatsApp Web changes regularly. If the QR code stops appearing, update the WhatsApp library:

```powershell
cd server
$env:PUPPETEER_SKIP_DOWNLOAD="true"; npm install github:pedroslopez/whatsapp-web.js#main
```

## License

Apache 2.0 with Commons Clause (free to use and modify, not to sell). See [LICENSE](LICENSE).\
Based on [whatsapp-contact-sync](https://github.com/guyzyl/whatsapp-contact-sync) by Guy Zylberberg.
