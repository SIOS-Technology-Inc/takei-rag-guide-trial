# local.settings.jsonのテンプレートファイルを読み込み、src/backend/local.settings.jsonを作成する
cat scripts\local.settings.json > .\src\backend\local.settings.json

# フロントエンドで使用する.env.productionを作成
echo 'VITE_API_ENDPOINT="your_static_web_apps_url"' > .\src\frontend\.env.production

# インデクサーのPythonスクリプトを実行するためのPython仮想環境を作成し、依存関係をインストールする
Write-Host 'Creating python virtual environment "scripts\.venv"'
python -m venv .\scripts\.venv

Write-Host 'Installing dependencies from "requirements.txt" into virtual environment'
.\scripts\.venv\Scripts\python -m pip install -r .\scripts\requirements.txt

# バックエンド(Azure Functions)を実行するためのPython仮想環境を作成する。
Write-Host 'Creating python virtual environment "src\backend\.venv"'
python -m venv .\src\backend\.venv

# インデクサーを実行する
.\scripts\.venv\Scripts\python .\scripts\indexer.py --docs .\data\*
