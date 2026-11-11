#!/usr/bin/env bash
# Web uygulamasını (../index.html + ../data) www/ klasörüne kopyalar. Capacitor uygulamaya bu klasörü gömer.
set -euo pipefail
cd "$(dirname "$0")"
rm -rf www && mkdir -p www/data
cp ../index.html www/index.html
cp ../data/vocabulary_en-tr.json www/data/
echo "www hazır: $(du -sh www | cut -f1)"
