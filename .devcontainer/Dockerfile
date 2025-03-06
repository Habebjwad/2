# Use an official Ubuntu image
FROM ubuntu:22.04

# Avoid interactive prompts during package installs
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    sudo \
    xfce4 \
    xfce4-goodies \
    xrdp \
    curl \
    gnupg \
    lsb-release \
    dbus-x11 \
    && rm -rf /var/lib/apt/lists/*

# Configure XRDP to use XFCE
RUN sed -i.bak 's/^\(.*startwm.sh\)/#\1/' /etc/xrdp/startwm.sh && \
    echo "startxfce4" >> /etc/xrdp/startwm.sh

# Install Tailscale using the official install script
RUN curl -fsSL https://tailscale.com/install.sh | sh

# (Optional) Expose the XRDP port
EXPOSE 3389

# Add a non-root user if not already present (GitHub Codespaces creates "vscode")
RUN id -u vscode &>/dev/null || useradd -ms /bin/bash vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to the vscode user (Codespaces default)
USER vscode

# Set the working directory
WORKDIR /workspaces

# Copy the setup script into the container (we'll create this next)
COPY setup.sh /workspaces/setup.sh
RUN chmod +x /workspaces/setup.sh
