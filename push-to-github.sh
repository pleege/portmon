#!/bin/bash
# Push PortMon to GitHub

cd "$(dirname "$0")"

# Check if remote exists
if ! git remote | grep -q origin; then
    echo "Adding remote origin..."
    git remote add origin git@github.com:pleege/portmon.git
fi

echo "Pushing to GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Successfully pushed to https://github.com/pleege/portmon"
else
    echo ""
    echo "❌ Push failed. Please create the repository first:"
    echo "   https://github.com/new?name=portmon"
    echo ""
    echo "Then run this script again."
fi
