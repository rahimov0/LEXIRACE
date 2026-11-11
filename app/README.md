# LexiRace iOS (Capacitor)

Web uygulaması `../index.html`. Bu klasör onu iOS uygulaması olarak paketler (web dosyaları uygulamanın içine gömülür).

Gereksinim: **Xcode 26+** (Capacitor 8 ve App Store gönderimi için), Node 22+.

```bash
cd app
npm install
npm run ios        # web'i kopyalar, sync eder, Xcode'u açar
```
Xcode'da: App hedefi → Signing & Capabilities → Team seç, "Automatically manage signing" açık kalsın.
Bundle ID: `tr.rahimov.lexirace` (değiştirirsen `capacitor.config.json` ve Xcode'da aynısını yaz).
Arşiv: Product → Archive → Distribute App → App Store Connect.
