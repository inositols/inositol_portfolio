#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== Starting Flutter Web Deployment to Vercel ==="

# 1. Verify Environment Variables
if [ -z "$VERCEL_TOKEN" ]; then
    echo "Error: VERCEL_TOKEN environment variable is not set." >&2
    exit 1
fi

if [ -z "$VERCEL_ORG_ID" ] || [ -z "$VERCEL_PROJECT_ID" ]; then
    echo "Warning: VERCEL_ORG_ID or VERCEL_PROJECT_ID is not set. Deployment will run in interactive link mode unless configured."
fi

# 2. Verify Flutter installation
if ! command -v flutter &> /dev/null; then
    echo "Error: Flutter SDK is not installed or not in the system PATH." >&2
    exit 1
fi

# 3. Clean and Install dependencies
echo "Installing dependencies..."
flutter pub get

# 4. Compile the Flutter web application
echo "Building Flutter Web application (Production)..."
flutter build web --release

# 5. Generate vercel.json SPA Routing Configuration
echo "Generating SPA routing configuration (vercel.json)..."
cat << 'EOF' > vercel.json
{
  "cleanUrls": true,
  "rewrites": [
    { "source": "/(.*)", "destination": "/index.html" }
  ]
}
EOF

# Copy configuration to build output folder
cp vercel.json build/web/vercel.json

# 6. Deploy via Vercel CLI
echo "Deploying build/web directory to Vercel..."
if [ -n "$VERCEL_ORG_ID" ] && [ -n "$VERCEL_PROJECT_ID" ]; then
    # Unattended production deployment using environment variables
    npx -y vercel deploy build/web --prod --token="$VERCEL_TOKEN" --yes
else
    # Interactive/Default deployment (will prompt or attempt auto-link)
    npx -y vercel deploy build/web --prod --token="$VERCEL_TOKEN"
fi

echo "=== Deployment Finished Successfully! ==="
