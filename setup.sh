#!/bin/bash
set -e

# Start the XRDP service (using sudo because it needs elevated privileges)
echo "Starting XRDP..."
sudo service xrdp start

# Start the Tailscale daemon in the background.
echo "Starting Tailscale daemon..."
sudo tailscaled &

# Wait a few seconds for tailscaled to initialize.
sleep 5

# Bring up Tailscale using the provided auth token.
# WARNING: In public projects, avoid hard-coding sensitive tokens.
echo "Connecting Tailscale..."
sudo tailscale up --authkey=tskey-auth-kQ7f7jymh421CNTRL-dQ2aWwNPZ1jq4p9TBc2T1jrbWSKA24Pti --accept-routes

echo "Setup complete. XRDP is running on port 3389."
