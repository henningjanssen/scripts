#!/bin/bash
set -e

echo "Arg: $1"

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	echo "Available args: performance, powersave"
	exit 0
fi
if [ "$1" == "performance" ]; then
	echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
else
	echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
fi

echo "Status:"
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
