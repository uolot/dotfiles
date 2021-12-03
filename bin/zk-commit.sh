#!/usr/bin/env bash

FILE="$1"
DIR="$(dirname "$FILE")"
NAME="$(basename "$FILE")"

cd "$DIR"

git rev-parse --git-dir $FILE > /dev/null 2>&1 || { echo "error"; exit 1; }

MESSAGE="$(date +'%Y-%m-%d') $NAME"
echo $MESSAGE

git add .
git commit -m "$MESSAGE"
git pull
git push
