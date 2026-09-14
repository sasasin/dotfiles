#!/bin/bash -v
# --------------------------------------------------------------------
# AMD GPU Driver
# https://instinct.docs.amd.com/projects/amdgpu-docs/en/latest/
# --------------------------------------------------------------------
sudo apt install "linux-headers-$(uname -r)"

# Make the directory if it doesn't exist yet.
# This location is recommended by the distribution maintainers.
sudo mkdir --parents --mode=0755 /etc/apt/keyrings

# Download the key, convert the signing-key to a full
# keyring required by apt and store in the keyring directory
wget https://repo.radeon.com/rocm/rocm.gpg.key -O - | \
    gpg --dearmor | sudo tee /etc/apt/keyrings/rocm.gpg > /dev/null

sudo rm -f /etc/apt/sources.list.d/amdgpu.list
sudo tee /etc/apt/sources.list.d/amdgpu.list << EOF
deb [arch=amd64 signed-by=/etc/apt/keyrings/rocm.gpg] https://repo.radeon.com/amdgpu/31.50/ubuntu resolute main
EOF
sudo cat /etc/apt/sources.list.d/amdgpu.list

sudo apt update
sudo apt install amdgpu-dkms
# LUKS のパスワードによるストレージ暗号化やってるなら必須。
# ubuntu2604 は dracut 管理だが、amdgpu-dkms が initramfs 管理のため、
# dracut をアンインストールして initramfs に差し替えてくる。
# パスワードによるストレージ暗号化やってる場合、
# 素の initramfs から パスワード画面にパスするための cryptsetup-initramfs が必要。
sudo apt install cryptsetup-initramfs

