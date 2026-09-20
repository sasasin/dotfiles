#!/usr/bin/env bash
set -u -o pipefail

# Radeon AI PRO R9700 (Navi 48) PCI IDs. The BDF is discovered at runtime
# because it depends on the current PCIe topology and is not model-specific.
PCI_VENDOR_ID=0x1002
PCI_DEVICE_ID=0x7551
CAP_W="${CAP_W:-250}"
BDF=""
H=""

# Return a BDF only when exactly one matching amdgpu device is present.
detect_bdf() {
    local d vendor device driver
    local -a candidates=()

    for d in /sys/bus/pci/devices/*; do
        [[ -d "$d" ]] || continue
        [[ -r "$d/vendor" && -r "$d/device" ]] || continue

        vendor=$(<"$d/vendor")
        device=$(<"$d/device")
        [[ "$vendor" == "$PCI_VENDOR_ID" && "$device" == "$PCI_DEVICE_ID" ]] || continue

        [[ -L "$d/driver" ]] || continue
        driver=$(basename "$(readlink "$d/driver")")
        [[ "$driver" == amdgpu ]] || continue

        candidates+=("${d##*/}")
    done

    (( ${#candidates[@]} == 1 )) || return 1
    printf '%s\n' "${candidates[0]}"
}

# Wait for the PCI device and amdgpu hwmon interface to appear during boot.
for _ in {1..60}; do
    BDF=$(detect_bdf 2>/dev/null || true)
    if [[ -n "$BDF" ]]; then
        for h in /sys/bus/pci/devices/$BDF/hwmon/hwmon*; do
            if [[ -r "$h/name" ]] && [[ "$(<"$h/name")" == "amdgpu" ]] &&
               [[ -w "$h/power1_cap" ]]; then
                H="$h"
                break 2
            fi
        done
    fi
    sleep 1
done

if [[ -z "$BDF" || -z "$H" ]]; then
    echo "Could not uniquely detect an amdgpu Radeon AI PRO R9700 (1002:7551) with a writable power cap." >&2
    exit 1
fi

if [[ ! "$CAP_W" =~ ^[0-9]+$ ]]; then
    echo "CAP_W must be an integer number of watts: $CAP_W" >&2
    exit 1
fi

min_cap=$(<"$H/power1_cap_min")
max_cap=$(<"$H/power1_cap_max")
cap=$((CAP_W * 1000000))

# Clamp the requested value to the limits reported by the GPU firmware.
(( cap < min_cap )) && cap=$min_cap
(( cap > max_cap )) && cap=$max_cap

printf '%s\n' "$cap" > "$H/power1_cap"

if [[ "$(<"$H/power1_cap")" != "$cap" ]]; then
    echo "GPU power cap was not applied: requested ${cap} uW at $H" >&2
    exit 1
fi

printf 'Applied Radeon AI PRO R9700 power cap: %s W (BDF=%s)\n' \
    "$((cap / 1000000))" "$BDF"
