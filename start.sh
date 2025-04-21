#!/bin/bash

echo "🔄 Instalacja zależności..."
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip

echo "🐍 Instalacja bibliotek Python..."
pip install numpy
pip install ta-lib-bin
pip install freqtrade

echo "🖥 Instalacja UI Freqtrade..."
freqtrade install-ui

echo "🚀 Uruchamianie Freqtrade Web..."
freqtrade webserver --config config.json
