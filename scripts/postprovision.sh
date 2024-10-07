#!/bin/bash

# フロントエンドで使用する.env.productionを作成
echo 'VITE_API_ENDPOINT="your_static_web_apps_url"' > ./src/frontend/.env.production

# Azure CLI をインストール
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Nodejsのインストール（Static Web Apps CLIで使用）
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Static Web Apps CLI (SWA CLI) をインストール
yarn add @azure/static-web-apps-cli

# Azure Functions Core Tools をインストール
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/debian/$(lsb_release -rs | cut -d'.' -f 1)/prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'
sudo apt update
sudo apt install azure-functions-core-tools-4

# インデクサーのPythonスクリプトを実行するためのPython仮想環境を作成し、依存関係をインストールする
echo 'Creating python virtual environment "scripts/.venv"'
python -m venv scripts/.venv

echo 'Installing dependencies from "requirements.txt" into virtual environment'
./scripts/.venv/bin/python -m pip install -r scripts/requirements.txt

# インデクサーを実行する
./scripts/.venv/bin/python scripts/indexer.py --docs ./data/* 