#!/bin/bash
# Laravel Cloud API provisioning script
# Demonstrates creating a full environment via the API
#
# Prerequisites:
#   export LARAVEL_CLOUD_TOKEN="your-api-token"
#
# Usage:
#   ./scripts/provision.sh

set -euo pipefail

API_BASE="https://cloud.laravel.com/api"
REGION="us-east-1"

if [ -z "${LARAVEL_CLOUD_TOKEN:-}" ]; then
  echo "Error: LARAVEL_CLOUD_TOKEN environment variable is required"
  exit 1
fi

api() {
  local method=$1
  local endpoint=$2
  shift 2
  curl -s -X "$method" "${API_BASE}${endpoint}" \
    -H "Authorization: Bearer $LARAVEL_CLOUD_TOKEN" \
    -H "Content-Type: application/vnd.api+json" \
    -H "Accept: application/vnd.api+json" \
    "$@"
}

echo "=== Laravel Cloud Provisioning ==="

# Step 1: Create application
echo "Creating application..."
APP_RESPONSE=$(api POST /applications -d '{
  "repository": "your-org/your-repo",
  "name": "eval-test-app",
  "region": "'"$REGION"'"
}')
APP_ID=$(echo "$APP_RESPONSE" | jq -r '.data.id')
echo "Application created: $APP_ID"

# Step 2: Get the default environment
echo "Fetching environments..."
ENV_RESPONSE=$(api GET "/applications/$APP_ID/environments")
ENV_ID=$(echo "$ENV_RESPONSE" | jq -r '.data[0].id')
ENV_SLUG=$(echo "$ENV_RESPONSE" | jq -r '.data[0].attributes.slug')
echo "Default environment: $ENV_SLUG ($ENV_ID)"

# Step 3: Create a database cluster
echo "Creating MySQL database cluster..."
DB_RESPONSE=$(api POST /databases/clusters -d '{
  "type": "laravel_mysql_84",
  "name": "eval-db",
  "region": "'"$REGION"'",
  "config": {
    "size": "db-flex.m-1vcpu-512mb",
    "storage": 10,
    "is_public": false,
    "uses_scheduled_snapshots": true,
    "retention_days": 7
  }
}')
DB_ID=$(echo "$DB_RESPONSE" | jq -r '.data.id')
echo "Database cluster created: $DB_ID"

# Step 4: Set environment variables
echo "Setting environment variables..."
api POST "/environments/$ENV_SLUG/variables" -d '{
  "method": "replace",
  "variables": [
    {"key": "APP_NAME", "value": "Eval Test App"},
    {"key": "APP_ENV", "value": "production"},
    {"key": "APP_DEBUG", "value": "false"}
  ]
}' > /dev/null
echo "Environment variables set"

# Step 5: Deploy
echo "Initiating deployment..."
DEPLOY_RESPONSE=$(api POST "/environments/$ENV_SLUG/deployments")
DEPLOY_ID=$(echo "$DEPLOY_RESPONSE" | jq -r '.data.id')
DEPLOY_STATUS=$(echo "$DEPLOY_RESPONSE" | jq -r '.data.attributes.status')
echo "Deployment $DEPLOY_ID initiated (status: $DEPLOY_STATUS)"

echo ""
echo "=== Provisioning Complete ==="
echo "Application: $APP_ID"
echo "Environment: $ENV_SLUG"
echo "Database:    $DB_ID"
echo "Deployment:  $DEPLOY_ID ($DEPLOY_STATUS)"
