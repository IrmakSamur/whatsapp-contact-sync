# WhatsApp Contact Sync – lokaal gebruiken

## Eenmalig: Google-koppeling aanmaken (± 10 min)

1. Ga naar https://console.cloud.google.com en maak een nieuw project aan (bv. "WhaSync").
2. **APIs & Services → Library** → zoek **Google People API** → **Enable**.
3. **APIs & Services → OAuth consent screen** (Google Auth Platform):
   - User type: **External**, app-naam: iets als "WhaSync", vul je eigen e-mail in.
   - Bij **Audience / Test users**: voeg je eigen Gmail-adres toe.
   - Laat de app in **Testing** staan (publiceren is niet nodig).
4. **APIs & Services → Credentials → Create credentials → OAuth client ID**:
   - Application type: **Web application**
   - **Authorized redirect URIs**: `http://localhost:4000/api/google_callback`
     (let op: poort **4000**, niet 8080 zoals in de originele README staat)
5. Kopieer de **Client ID** en **Client secret** naar `server\.env`:
   ```
   GOOGLE_CLIENT_ID=....apps.googleusercontent.com
   GOOGLE_CLIENT_SECRET=GOCSPX-...
   ```

## Elke keer dat je wilt bijwerken (bv. 1× per maand)

1. Rechtermuisklik op `start.ps1` → **Uitvoeren met PowerShell**
   (of in PowerShell: `powershell -ExecutionPolicy Bypass -File start.ps1`)
2. De browser opent op http://localhost:4000 → **Get Started**
3. Scan de QR-code met WhatsApp (Instellingen → Gekoppelde apparaten → Apparaat koppelen)
4. Log in met Google. Je krijgt de melding "Google heeft deze app niet geverifieerd" →
   **Doorgaan** (het is je eigen app).
5. Kies opties:
   - **Overwrite photos** uit = alleen contacten zonder foto krijgen er een
   - **Manual sync** aan = per contact goedkeuren
6. Wachten (± 1,5 sec per foto). Klaar → sluit de twee PowerShell-vensters.

Tip: verwijder daarna in WhatsApp onder *Gekoppelde apparaten* de gekoppelde sessie,
die wordt niet bewaard en is volgende keer toch opnieuw nodig.

## Lokale aanpassingen t.o.v. het origineel

- `server/src/whatsapp.ts`: gebruikt je eigen Chrome (`CHROME_PATH` in `.env`) en niet langer de
  verouderde vastgepinde WhatsApp Web-versie.
- `server/package-lock.json`: whatsapp-web.js bijgewerkt naar de nieuwste versie (fix voor de huidige WhatsApp Web).
- `web/vite.config.ts` + `web/src/services/ws.ts`: WebSocket-verbinding gerepareerd (QR-code verscheen anders niet).

## Op een andere pc

Vereist: Node.js en Google Chrome. Het Google Cloud-project hoeft niet opnieuw.

```
git clone https://github.com/IrmakSamur/whatsapp-contact-sync.git C:\dev\projects\Whatsapp-Contact-Sync
cd C:\dev\projects\Whatsapp-Contact-Sync\server
$env:PUPPETEER_SKIP_DOWNLOAD="true"; npm install
cd ..\web; npm install
```

Maak daarna `server\.env` aan (staat bewust niet op GitHub) met:
```
GOOGLE_CLIENT_ID=<uit je wachtwoordmanager>
GOOGLE_CLIENT_SECRET=<uit je wachtwoordmanager>
CHROME_PATH=C:\Program Files\Google\Chrome\Application\chrome.exe
```
Secret kwijt? Google Cloud → project WhaSync → Google Auth Platform → Clients → WhaSync lokaal → Add secret.

## Als het ooit niet meer werkt

WhatsApp Web verandert regelmatig. Meestal helpt het om de bibliotheek bij te werken:
```
cd server
$env:PUPPETEER_SKIP_DOWNLOAD="true"; npm install github:pedroslopez/whatsapp-web.js#main
```
