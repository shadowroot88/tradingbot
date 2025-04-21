#!/bin/bash

echo "🔧 Aktualizacja systemu i instalacja zależności..."

apt-get update -y
apt-get install -y build-essential wget git curl libffi-dev libtool autoconf automake \
    python3-dev python3-pip

echo "📦 Pobieranie i instalacja TA-Lib z kodu źródłowego..."

cd /tmp
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xvzf ta-lib-0.4.0-src.tar.gz
cd ta-lib
./configure --prefix=/opt/ta-lib
make
make install

echo "🔄 Ustawianie ścieżek do TA-Lib..."
export TA_INCLUDE_PATH=/opt/ta-lib/include
export TA_LIBRARY_PATH=/opt/ta-lib/lib
export LD_LIBRARY_PATH=$TA_LIBRARY_PATH:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$TA_INCLUDE_PATH:$C_INCLUDE_PATH
export LIBRARY_PATH=$TA_LIBRARY_PATH:$LIBRARY_PATH

echo "🐍 Instalacja Freqtrade i TA-Lib (Python)..."
pip install --upgrade pip
pip install numpy
pip install TA-Lib --no-cache-dir
pip install freqtrade

echo "🖥 Instalacja interfejsu webowego Freqtrade UI..."
freqtrade install-ui

echo "🚀 Uruchamianie bota z interfejsem webowym..."
freqtrade webserver --config config.json
