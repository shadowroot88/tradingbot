#!/bin/bash

echo "📦 Instalacja zależności systemowych..."
apt-get update -y && apt-get install -y build-essential curl git libssl-dev libffi-dev python3-dev

echo "🐍 Tworzenie środowiska Python i instalacja wymaganych bibliotek..."
python3 -m venv .venv
source .venv/bin/activate

pip install --upgrade pip
pip install numpy
pip install ta-lib-bin
pip install freqtrade

echo "🖥 Instalacja interfejsu webowego Freqtrade UI..."
freqtrade install-ui

echo "🚀 Uruchamianie bota Freqtrade z interfejsem webowym..."
freqtrade webserver --config config.json