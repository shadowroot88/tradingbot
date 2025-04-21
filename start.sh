#!/bin/bash
set -e

echo "🔧 Instalacja TA-Lib lokalnie..."
cd /tmp
curl -L -o ta-lib.tar.gz http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xzf ta-lib.tar.gz
cd ta-lib
./configure --prefix=$HOME/.local && make -j$(nproc) && make install

export TA_INCLUDE_PATH=$HOME/.local/include
export TA_LIBRARY_PATH=$HOME/.local/lib
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH

echo "📦 Instalacja Freqtrade i TA-Lib (Python)..."
pip install --upgrade pip
pip install freqtrade TA-Lib

echo "🚀 Start Freqtrade..."
freqtrade trade --config config.json