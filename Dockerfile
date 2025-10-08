# --- ステージ1: ソースコードの取得 ---
FROM alpine/git:latest AS cloner

# 作業ディレクトリを設定
WORKDIR /git

# リポジトリをサブモジュール付きで特定のブランチをクローンします
RUN git clone --recurse-submodules --branch v0.1-preview --depth 1 https://github.com/Yukkurisiteikitai/Y_sys.git .


# --- ステージ2: 実行環境の構築 ---
# 指定されたPython 3.11.7をベースイメージとして使用
# slim版は軽量でおすすめです
FROM python:3.11.7-slim

# 作業ディレクトリを /app に設定
WORKDIR /app

# 依存関係の定義ファイル(requirements.txt)を先にコピーします
# これにより、ソースコードの変更時に毎回pip installが走るのを防ぎ、ビルドを高速化できます
COPY --from=cloner /git/Y-sys-backend/requirements.txt /app/Y-sys-backend/requirements.txt
COPY --from=cloner /git/Y-sys-frontend/requirements.txt /app/Y-sys-frontend/requirements.txt

# バックエンドの依存関係をインストールします
# --no-cache-dir オプションは、不要なキャッシュを残さずイメージサイズを小さく保ちます
RUN pip install --no-cache-dir -r /app/Y-sys-backend/requirements.txt

# フロントエンドの依存関係をインストールします
RUN pip install --no-cache-dir -r /app/Y-sys-frontend/requirements.txt

# アプリケーションのソースコード全体をコピーします
COPY --from=cloner /git/ .

# 初期化
CMD ["bash"]