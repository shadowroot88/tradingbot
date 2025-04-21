#!/bin/bash

echo "📦 Instalacja zależności systemowych..."
apt-get update -y
apt-get install -y libffi-dev libssl-dev build-essential curl git python3-dev

echo "🐍 Aktualizacja pip i instalacja TA-Lib z gotowej paczki..."
pip install --upgrade pip
pip install numpy
pip install ta-lib-bin

echo "📥 Instalacja Freqtrade i interfejsu webowego..."
pip install freqtrade
freqtrade install-ui

echo "🚀 Uruchamianie bota Freqtrade..."
freqtrade webserver --config config.json