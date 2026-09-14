#!/bin/bash -v
# --------------------------------------------------------------------
# AMD ROCm
# https://rocm.docs.amd.com/en/latest/index.html
# --------------------------------------------------------------------
sudo apt update
sudo apt install sudo wget gpg perl
sudo apt install libatomic1 libquadmath0

# Add the current user to the render and video groups
sudo usermod -a -G render,video $LOGNAME

sudo rm -f /etc/udev/rules.d/70-amdgpu.rules
sudo tee /etc/udev/rules.d/70-amdgpu.rules << EOF
KERNEL=="kfd", GROUP="render", MODE="0666"
SUBSYSTEM=="drm", KERNEL=="renderD*", GROUP="render", MODE="0666"
EOF
sudo cat /etc/udev/rules.d/70-amdgpu.rules

sudo udevadm control --reload-rules
sudo udevadm trigger

# Download and install GPG key
sudo mkdir --parents --mode=0755 /etc/apt/keyrings

# ROCm release signing key
wget https://stable.repo.amd.com/rocm/gpg/packages.gpg -O - | \
    gpg --dearmor | sudo tee /etc/apt/keyrings/amdrocm.gpg > /dev/null

sudo rm -f /etc/apt/sources.list.d/amdrocm-stable.sources
sudo tee /etc/apt/sources.list.d/amdrocm-stable.sources << EOF
X-Repo-Id: amdrocm-stable
Types: deb
URIs: https://stable.repo.amd.com/rocm/core/packages/ubuntu2604/
Suites: stable
Components: main
Architectures: amd64
Signed-By: /etc/apt/keyrings/amdrocm.gpg
Enabled: yes
EOF
sudo cat /etc/apt/sources.list.d/amdrocm-stable.sources

sudo apt update
sudo apt install amdrocm10.0-gfx1201

