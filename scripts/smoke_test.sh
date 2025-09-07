#!/bin/bash
API_URL=$1
set -e

echo "Running smoke tests on $API_URL"

curl -fsS ${API_URL}/health || { echo "Health check failed"; exit 1; }

curl -fsS -X POST -H "Content-Type: application/json" \
  -d '{"title":"test","body":"hello"}' \
  ${API_URL}/notes || { echo "Create note failed"; exit 1; }

echo "✅ Smoke tests passed"

