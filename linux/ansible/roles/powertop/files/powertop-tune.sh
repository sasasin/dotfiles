#!/bin/bash
/usr/sbin/powertop --auto-tune

# suspend off USB connected devices.
ls /sys/bus/usb/devices/1-*/power/control \
| while read f; do
  echo "on" > $f
done
