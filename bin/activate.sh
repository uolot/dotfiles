#!/usr/bin/env bash

if [ -f "$1/bin/activate" ]; then
  source "$1/bin/activate"
  return 0
fi

# FOUND=$(find . | grep 'bin/activate$')
FOUND=$(fd --hidden --no-ignore --max-depth 3 --full-path --type f --glob '*/bin/activate')
for f in $FOUND; do
  if grep --quiet VIRTUAL_ENV $f; then
    echo $FOUND
    source $f
    break
  fi
done
