#!/bin/bash

echo "🔧 Aktualizacja systemu i instalacja zależności..."

sudo apt-get update -y
sudo apt-get install -y build-essential wget git curl libffi-dev libtool autoconf automake \
    python3-dev python3-pip

echo "📦 Pobieranie i instalacja TA-Lib z kodu źródłowego..."

cd /tmp
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xvzf ta-lib-0.4.0-src.tar.gz
cd ta-lib
./configure --prefix=/usr/local
make
sudo make install

echo "🔄 Ustawianie ścieżek do TA-Lib..."
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=/usr/local/include:$C_INCLUDE_PATH
export LIBRARY_PATH=/usr/local/lib:$LIBRARY_PATH

echo "🐍 Instalacja Freqtrade i TA-Lib (Python)..."
pip install --upgrade pip
pip install numpy
pip install TA-Lib
pip install freqtrade

echo "🖥 Instalacja interfejsu webowego Freqtrade UI..."
freqtrade install-ui

echo "🚀 Uruchamianie bota z interfejsem webowym..."
cd freqtrade
freqtrade webserver --config config.json