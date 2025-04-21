#!/bin/bash
set -e

echo "🔧 Instalacja TA-Lib lokalnie w przestrzeni użytkownika..."
mkdir -p .local
cd .local
curl -L -o ta-lib.tar.gz http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xzf ta-lib.tar.gz
cd ta-lib
./configure --prefix=$(pwd)/../.local && make -j$(nproc) && make install

# Ustawienie zmiennych środowiskowych dla TA-Lib
export TA_INCLUDE_PATH=$(pwd)/../.local/include
export TA_LIBRARY_PATH=$(pwd)/../.local/lib
export LD_LIBRARY_PATH=$(pwd)/../.local/lib:$LD_LIBRARY_PATH

echo "📦 Instalacja zależności Pythona (Freqtrade i TA-Lib)..."
pip install --upgrade pip
pip install --user freqtrade TA-Lib

echo "🚀 Uruchamianie Freqtrade..."
freqtrade trade --config config.json