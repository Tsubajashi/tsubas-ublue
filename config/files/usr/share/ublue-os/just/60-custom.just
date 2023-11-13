
!include /usr/share/ublue-os/just/100-bling.just

# Include some of your custom scripts here!

# Install Bazzite-Arch for Gaming
install-bazzite-arch-qt:
  distrobox-create --unshare-netns --nvidia --image ghcr.io/ublue-os/bazzite-arch --name bazzite-arch -Y && \
  echo 'Exporting applications...' && \
  distrobox-enter -n bazzite-arch -- 'bash -c "sudo locale-gen && distrobox-export --app steam && distrobox-export --app lutris && distrobox-export --app protontricks && mkdir -p $HOME/.steam && distrobox-export --bin /usr/bin/steamcmd --export-path ~/.steam && mv $HOME/.steam/steamcmd $HOME/.steam/steamcmd.sh"' && \
  echo 'Starting Steam...' && \
  distrobox-enter -n bazzite-arch -- '  /usr/bin/bazzite-steam-runtime --silent &>/dev/null &' && \
  echo 'Finalizing...' && \
  sleep 10

install-bazzite-arch-gtk:
  distrobox-create --unshare-netns --nvidia --image ghcr.io/ublue-os/bazzite-arch-gnome --name bazzite-arch -Y && \
  echo 'Exporting applications...' && \
  distrobox-enter -n bazzite-arch -- 'bash -c "sudo locale-gen && distrobox-export --app steam && distrobox-export --app lutris && distrobox-export --app protontricks && mkdir -p $HOME/.steam && distrobox-export --bin /usr/bin/steamcmd --export-path ~/.steam && mv $HOME/.steam/steamcmd $HOME/.steam/steamcmd.sh"' && \
  echo 'Starting Steam...' && \
  distrobox-enter -n bazzite-arch -- '  /usr/bin/bazzite-steam-runtime --silent &>/dev/null &' && \
  echo 'Finalizing...' && \
  sleep 10

# Enable Cockpit for web-based system management | https://cockpit-project.org/
cockpit:
  echo 'Enabling Cockpit'
  echo 'PasswordAuthentication yes' | sudo tee /etc/ssh/sshd_config.d/02-enable-passwords.conf
  sudo systemctl try-restart sshd
  sudo systemctl enable --now sshd
  sudo podman container runlabel --name cockpit-ws RUN quay.io/cockpit/ws
  sudo podman container runlabel INSTALL quay.io/cockpit/ws
  sudo systemctl enable cockpit.service

# Install JetBrains Toolbox | https://www.jetbrains.com/toolbox-app/
jetbrains-toolbox:
  #!/usr/bin/env bash
  pushd "$(mktemp -d)"
  echo "Get latest JetBrains Toolbox version"
  # Get the json with latest releases
  curl -sSfL -o releases.json "https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release"
  # Extract information
  BUILD_VERSION=$(jq -r '.TBA[0].build' ./releases.json)
  DOWNLOAD_LINK=$(jq -r '.TBA[0].downloads.linux.link' ./releases.json)
  CHECKSUM_LINK=$(jq -r '.TBA[0].downloads.linux.checksumLink' ./releases.json)
  echo "Installing JetBrains Toolbox ${BUILD_VERSION}"
  curl -sSfL -O "${DOWNLOAD_LINK}"
  curl -sSfL "${CHECKSUM_LINK}" | sha256sum -c
  tar zxf jetbrains-toolbox-"${BUILD_VERSION}".tar.gz
  echo "Launching JetBrains Toolbox"
  ./jetbrains-toolbox-"${BUILD_VERSION}"/jetbrains-toolbox
