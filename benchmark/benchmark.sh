#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <device-serial>"
    echo "  device-serial: ADB device serial number (run 'adb devices' to list)"
    exit 1
fi

DEVICE="$1"

mkdir -p ./results
mkdir -p ./completed_configs

for file in ./configs/*.json; do
    name="$(basename "$file" .json)"

    cd ../client
    python main.py --config ../benchmark/$file --output_path ../benchmark/results/$name --device "$DEVICE"
    cd -
    mv $file ./completed_configs
done