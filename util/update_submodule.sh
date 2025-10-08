#!/bin/bash

# --- 引数のチェック ---
# スクリプトの第1引数が空文字かどうかをチェックします
if [ -z "$1" ]; then
  echo "エラー: コミットメッセージを第1引数に指定してください。"
  echo "使用法: $0 \"あなたのコミットメッセージ\""
  exit 1
fi

# 第1引数をコミットメッセージ用の変数に格納します
COMMIT_MESSAGE=$1

# スクリプトの途中でエラーが発生した場合、その時点で処理を中断します
set -e

# --- Y-sys-frontend サブモジュールの更新 ---

echo "Updating Y-sys-frontend..."
cd Y-sys-frontend

# チェックアウトする前のブランチ名を取得して保存します
ORIGINAL_FRONTEND_BRANCH=$(git branch --show-current)
echo "  -> Original branch was: $ORIGINAL_FRONTEND_BRANCH"

# リモートリポジトリの最新情報を取得します
git fetch

# 'origin/main'の最新コミットハッシュを取得します
# 追跡したいブランチが異なる場合は 'main' の部分を適宜変更してください
FRONTEND_LATEST_HASH=$(git rev-parse origin/main)
echo "  -> Checking out to latest commit: $FRONTEND_LATEST_HASH"
git checkout $FRONTEND_LATEST_HASH

# 親ディレクトリに戻ります
cd ..

# --- Y-sys-backend サブモジュールの更新 ---

echo "Updating Y-sys-backend..."
cd Y-sys-backend

# チェックアウトする前のブランチ名を取得して保存します
ORIGINAL_BACKEND_BRANCH=$(git branch --show-current)
echo "  -> Original branch was: $ORIGINAL_BACKEND_BRANCH"

# リモートリポジトリの最新情報を取得します
git fetch

# 'origin/main'の最新コミットハッシュを取得します
# 追跡したいブランチが異なる場合は 'main' の部分を適宜変更してください
BACKEND_LATEST_HASH=$(git rev-parse origin/main)
echo "  -> Checking out to latest commit: $BACKEND_LATEST_HASH"
git checkout $BACKEND_LATEST_HASH

# 親ディレクトリに戻ります
cd ..


# --- 親リポジトリでのコミット ---

echo "Staging and committing submodule changes..."

# サブモジュールの更新（参照するコミットの変更）をステージングします
git add Y-sys-frontend Y-sys-backend

# 第1引数で受け取ったメッセージを使ってコミットします
git commit -m "$COMMIT_MESSAGE"

echo "✅ Submodule updates committed to the parent repository."


# --- サブモジュールを元のブランチに戻す ---

echo "Restoring original branches in submodules..."

cd Y-sys-frontend
echo "  -> Checking out back to '$ORIGINAL_FRONTEND_BRANCH' in Y-sys-frontend..."
git checkout $ORIGINAL_FRONTEND_BRANCH
cd ..

cd Y-sys-backend
echo "  -> Checking out back to '$ORIGINAL_BACKEND_BRANCH' in Y-sys-backend..."
git checkout $ORIGINAL_BACKEND_BRANCH
cd ..

echo "✅ Done!"
echo "Submodules are now back on their original branches."