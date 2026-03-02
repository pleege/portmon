#!/bin/bash
#
# PortMon Installation Script
#

set -e

echo "=== PortMon Installation ==="
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Error: Please run as root (use sudo)"
    exit 1
fi

# Check dependencies
if ! command -v iptables &> /dev/null; then
    echo "Error: iptables is required but not installed"
    exit 1
fi

# Copy binary
echo "Installing portmon to /usr/local/bin/..."
cp portmon /usr/local/bin/portmon
chmod +x /usr/local/bin/portmon

# Create data directory
echo "Creating data directories..."
mkdir -p /var/lib/portmon/hourly /var/lib/portmon/daily

# Setup iptables
echo "Setting up iptables rules..."
portmon setup

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Usage:"
echo "  portmon status              # View current traffic"
echo "  portmon report today        # View today's statistics"
echo "  portmon live &              # Start background recording"
echo ""
echo "To enable systemd service:"
echo "  cp systemd/portmon.service /etc/systemd/system/"
echo "  systemctl enable --now portmon"
echo ""
