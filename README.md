# LexiRace

**THINK FAST. SPEAK ENGLISH.** — Turkish definition in, spoken English word out. 26 letters (A–Z), 10 seconds each.

- Single-file web app: `index.html` (open in Chrome/Edge for speech recognition; other browsers fall back to typing).
- 2,267 unique English words with Turkish explanations, levels A1–C2 (`data/vocabulary_en-tr.json`, embedded in `index.html`).
- Features: real browser speech recognition, PAS, pause/resume, review cards for missed words, sound effects toggle, voice picker, progress saved in localStorage.
- CEFR levels are suggested game-difficulty bands, not official certifications.

## Run
Open `index.html`, or enable GitHub Pages (Settings → Pages → main / root).

## Firebase kurulumu (ücretsiz Spark planı)
- **Authentication:** Email/Password açık olmalı (uygulama sahte e-posta kullanır, kullanıcı e-posta görmez).
- **Firestore:** `firebase/firestore.rules` içeriğini Console → Firestore → Rules'a yapıştırıp Publish et (hesaplar + günlük sıralama).
- **Realtime Database:** `firebase/database.rules.json` içeriğini Console → Realtime Database → Rules'a yapıştırıp Publish et (1v1 düello odaları).
- Spark planında sunucu kodu yok: skorlar istemciden gelir, kurallar sadece makul sınırları (0–26, süre aralığı, günde tek kayıt) zorlar.
