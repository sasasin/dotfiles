#!/usr/bin/env bash -v

sudo install -o root -g root -m 0755 \
  r9700-power-fan.sh \
  /usr/local/sbin/r9700-power-fan.sh

sudo install -o root -g root -m 0644 \
  r9700-power-fan.service \
  /etc/systemd/system/r9700-power-fan.service

sudo systemctl daemon-reload
sudo systemctl enable --now r9700-power-fan.service

systemctl status r9700-power-fan.service
sudo amd-smi monitor -g 0 -p -t -f -w 2 -W 10

