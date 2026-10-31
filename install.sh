#!/bin/sh
# Adds the Kibitz apt repository to this machine (#1586), then:
#   sudo apt install kbz && sudo kbz setup
set -eu
if [ "$(id -u)" -ne 0 ]; then echo "Run this as root: curl -fsSL https://aagdere.github.io/kbz/install.sh | sudo sh" >&2; exit 1; fi
apt-get update -qq
apt-get install -y -qq ca-certificates curl >/dev/null
install -d -m 0755 /usr/share/keyrings
curl -fsSL https://aagdere.github.io/kbz/kibitz-archive-keyring.gpg -o /usr/share/keyrings/kibitz-archive-keyring.gpg
chmod 0644 /usr/share/keyrings/kibitz-archive-keyring.gpg
cat > /etc/apt/sources.list.d/kibitz.sources <<EOF
Types: deb
URIs: https://aagdere.github.io/kbz
Suites: stable
Components: main
Signed-By: /usr/share/keyrings/kibitz-archive-keyring.gpg
EOF
apt-get update -qq
echo "Added the Kibitz apt repository. Install Kibitz with: sudo apt install kbz, then choose what this machine does: sudo kbz setup"
