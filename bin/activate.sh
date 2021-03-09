#!/usr/bin/env bash

# activate venv from args
if [ -f "$1/bin/activate" ]; then
  echo Activating "$1/bin/activate"
  source "$1/bin/activate"
  return 0
fi

# activate poetry if available
if [ -f "pyproject.toml" ]; then
  echo Activating poetry shell
  grep 'tool\.poetry\.dependencies' pyproject.toml \
    && poetry shell \
    && return 0 \
    || echo "failed"
fi

# find venv
FOUND=$(fd --hidden --no-ignore --max-depth 3 --full-path --type f | grep 'bin/activate$')
for f in $FOUND; do
  if grep --quiet VIRTUAL_ENV $f; then
    echo Activating "$f"
    source $f
    break
  fi
done
