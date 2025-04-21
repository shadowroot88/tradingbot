#!/bin/bash
set -e

echo "🔧 Installing TA-Lib locally in user space..."
cd /app
curl -L -o ta-lib.tar.gz http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xzf ta-lib.tar.gz
cd ta-lib
./configure --prefix=/app/.local && make -j$(nproc) && make install

# Set environment variables for TA-Lib
export TA_INCLUDE_PATH=/app/.local/include
export TA_LIBRARY_PATH=/app/.local/lib
export LD_LIBRARY_PATH=/app/.local/lib:$LD_LIBRARY_PATH

echo "📦 Installing Python dependencies (Freqtrade and TA-Lib)..."
pip install --upgrade pip
pip install --user freqtrade TA-Lib

echo "🚀 Starting Freqtrade..."
freqtrade trade --config config.json