#!/bin/bash
set -e

echo "🔧 Budowanie natywnego TA-Lib lokalnie..."
mkdir -p /tmp/build && cd /tmp/build
curl -L -o ta-lib.tar.gz http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xzf ta-lib.tar.gz
cd ta-lib
./configure --prefix=$HOME/.local
make -j$(nproc)
make install

echo "✅ TA-Lib zainstalowany lokalnie w $HOME/.local"

echo "🔧 Ustawiam ścieżki środowiskowe..."
export TA_INCLUDE_PATH=$HOME/.local/include
export TA_LIBRARY_PATH=$HOME/.local/lib
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

echo "🐍 Instalacja Freqtrade i Pythonowych zależności..."
pip install --upgrade pip
pip install TA-Lib freqtrade

echo "✅ Wszystko gotowe. Uruchamiam bota..."
freqtrade create-userdir --userdir user_data
cp config.json user_data/

# Jeśli masz strategię:
# cp SampleStrategy.py user_data/user_data/strategies/

freqtrade trade --config user_data/config.json
