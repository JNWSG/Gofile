#!/bin/bash

FILE="$1"
if [ -z "$FILE" ]; then
    echo "❌ Usage: ./gofile.sh path/to/your_rom.zip"
    exit 1
fi

if [ ! -f "$FILE" ]; then
    echo "❌ File not found: $FILE"
    exit 1
fi

FILENAME=$(basename "$FILE")
echo "📤 Uploading: $FILENAME to GoFile..."

RESPONSE=$(curl --progress-bar -X POST -F "file=@$FILE" https://store1.gofile.io/uploadFile)

LINK=$(echo "$RESPONSE" | jq -r '.data.downloadPage')

if [[ "$LINK" != "null" && -n "$LINK" ]]; then
    echo -e "\n✅ Upload successful!"
    echo "🔗 Download Link: $LINK"
else
    echo -e "\n❌ Upload failed!"
    echo "$RESPONSE"
fi
