# 概要
YourselfLMという自己分析可能なAIシステムの作成を目的としたプロジェクトです。


# インストール
## 通常
1. pythonをインストール


2. プロジェクトをインストール
```
git clone --recurse-submodules --branch v0.1-preview --depth 1 https://github.com/Yukkurisiteikitai/Y_sys.git .
# windowsの場合
start install.bat

# macの場合
source install.sh
```

<!-- ## docker
```
docker build -t y-sys-app .
docker run -it --rm y-sys-app
# -p 8000:8000 は、ホストマシンの8000番ポートをコンテナの8000番ポートに接続する設定です
docker run -it --rm -p 8000:8000 y-sys-app python Y-sys-backend/main_api.py
# フロントエンドが8501ポートを使う場合の例
docker run -it --rm -p 8501:8501 y-sys-app python -m uvicorn main:app --port 8010
``` -->