#!/bin/bash

DIR="$1"
OUT_FILE="$DIR/init.lua"

# Ensure the directory exists
if [[ ! -d "$DIR" ]]; then
  echo "Directory does not exist: $DIR"
  exit 1
fi

# Truncate (or create) init.lua safely
: >"$OUT_FILE"
echo "return {" >>"$OUT_FILE"

# Find *.lua files, exclude hidden & init.lua
for file in "$DIR"/*.lua; do
  filename=$(basename "$file" .lua)

  if [[ "$filename" == "init" || "$filename" == .* ]]; then
    continue
  fi

  # Convert slashes to dots
  lua_path="${DIR//\//.}.$filename"
  echo "  require(\"$lua_path\")," >>"$OUT_FILE"
done

echo "}" >>"$OUT_FILE"

echo "✅ Generated $OUT_FILE"
