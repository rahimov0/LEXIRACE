#!/usr/bin/env bash
# Web uygulamasını (../index.html + ../data + ../fonts) www/ klasörüne kopyalar. Capacitor uygulamaya bu klasörü gömer.
set -euo pipefail
cd "$(dirname "$0")"
rm -rf www && mkdir -p www/data
cp ../index.html www/index.html
VER=$(grep -m1 -o 'MARKETING_VERSION = [0-9.]*' ios/App/App.xcodeproj/project.pbxproj | grep -o '[0-9.]*$')
sed -i.bak "s/__APPV__/${VER}/" www/index.html && rm -f www/index.html.bak
cp ../data/vocabulary_en-tr.json www/data/
mkdir -p www/fonts && cp ../fonts/*.woff2 www/fonts/
echo "www hazır: $(du -sh www | cut -f1)"
