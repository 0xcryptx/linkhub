#!/bin/bash
# Verify link preview metadata - run after deploying to production
# Simulates Snapchat-like crawler checks for page and og:image

BASE_URL="https://www.yassinamin.com"
PAGE_URL="${BASE_URL}/"
IMAGE_URL="${BASE_URL}/assets/og-preview.png?v=2"
UA="Mozilla/5.0 (compatible; Snapchat; +https://www.snap.com)"

echo "=== 1. Page URL (HTTP status, redirects, content-type) ==="
curl -sI -L -A "$UA" "$PAGE_URL" | head -20

echo ""
echo "=== 2. OG Image URL (HTTP status, content-type, size) ==="
curl -sI -A "$UA" "$IMAGE_URL" | head -15

echo ""
echo "=== 3. Quick HTML meta extract (og:image, og:title) ==="
curl -s -A "$UA" "$PAGE_URL" | grep -E 'property="og:|name="twitter:' | head -20
