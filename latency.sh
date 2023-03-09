#!/usr/bin/bash

echo "Enter the target IP:"
read TARGET

echo "Connecting the target: $TARGET. ok? [y/N] "
read CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
	echo "Stopping the test"
	exit 1
fi

echo "Latency tests are starting.."
echo "Testing with ping.."

ping $TARGET -c 10

echo
echo "You can see round-trip-time min/avg/max/mdev."

echo
echo "Testing with traceroute.."

traceroute $TARGET

echo
echo "You can refer the output of ping for calculation."
