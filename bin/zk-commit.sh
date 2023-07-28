#!/usr/bin/env bash

ROOT=$HOME/Documents/ZK/
DOC=$1
FILE=${DOC/#$ROOT}

cd "$ROOT"

git rev-parse --git-dir $FILE > /dev/null 2>&1 || { echo "error"; exit 1; }

MESSAGE="$(date +'%Y-%m-%d') $FILE"
echo $MESSAGE

git add .
git commit -m "$MESSAGE"
git pull
git push
