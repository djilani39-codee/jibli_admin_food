# TestFlight CI (GitHub Actions) — Quick Guide

This project includes a GitHub Actions workflow to build an iOS .ipa and upload it to TestFlight using an App Store Connect API Key.

Overview
- Workflow file: `.github/workflows/ios-testflight.yml`
- Fastlane configuration: `fastlane/Fastfile`, `fastlane/Appfile`
- Helper script to encode secrets: `scripts/encode_secrets.ps1` (PowerShell)

Required GitHub Secrets
- `APP_STORE_CONNECT_KEY_ID` — Key ID from App Store Connect
- `APP_STORE_CONNECT_ISSUER_ID` — Issuer ID from App Store Connect
- `APP_STORE_CONNECT_PRIVATE_KEY_BASE64` — base64 content of your `.p8` API key file

Optional (for manual signing)
- `CERT_P12_BASE64` — base64 of your `.p12` certificate (if not using automatic provisioning)
- `CERT_P12_PASSWORD` — password for the `.p12`
- `PROVISIONING_PROFILE_BASE64` — base64 of your `.mobileprovision`
- `APP_SPECIFIC_PASSWORD` — app‑specific password (optional)

How to generate base64 on Windows (PowerShell)
1. Use the included script to convert file to base64 and copy to clipboard:
```powershell
cd C:\rest\jibli_admin_food
# API key .p8
.\scripts\encode_secrets.ps1 -Path 'C:\path\to\AuthKey_ABCDEF123.p8' -Out '.\tmp\appstore_key.base64.txt'

# optional cert and provisioning
.\scripts\encode_secrets.ps1 -Path 'C:\path\to\cert.p12' -Out '.\tmp\cert.p12.base64.txt'
.\scripts\encode_secrets.ps1 -Path 'C:\path\to\profile.mobileprovision' -Out '.\tmp\profile.mobileprovision.base64.txt'
```
The script prints the base64 and attempts to copy it to the clipboard. It also saves to the `tmp` files above.

How to add secrets to GitHub (UI)
1. Go to your repository → Settings → Secrets and variables → Actions → New repository secret.
2. Add each secret name and paste the base64 content (or values) per the list above.

How to run the workflow (after secrets are set)
1. In GitHub, go to the repo → Actions → iOS TestFlight Build → Run workflow.
2. Optionally provide `build_number` (keeps version from `pubspec.yaml` if empty).

Notes
- If channel/notification settings changed on Android, uninstall/reinstall app to recreate channels.
- For iOS custom notification sound, include `alarm.aiff` in Xcode: Target → Build Phases → Copy Bundle Resources.
- The workflow uses `fastlane` to upload the IPA to App Store Connect (API key).

If you want, I can:
- Prepare `fastlane match` configuration (recommended for automated signing).
- Help you add the secrets via `gh` CLI if you provide repo and you have `gh` authenticated here.
- Monitor workflow runs and help debug any failures — share the Actions run URL or logs.
