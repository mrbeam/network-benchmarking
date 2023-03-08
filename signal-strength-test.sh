#!/usr/bin/bash

SSID=$(nmcli -t --field IN-USE,SSID d wifi list | grep "*" | cut -d":" -f2)

if [ -z "$SSID" ]; then
	echo "Not connected to any wireless network"
	return 1
fi

echo "Connected to $SSID."
echo "Here are signal levels.."

sum_signal=0
for i in {1..10}
do
	level=$(nmcli -t --field IN-USE,SIGNAL d wifi list | grep "*" | cut -d":" -f2)
	echo "Sample #$i: $level"
	sum_signal=$(echo $level + $sum_signal | bc)
	sleep 5
done

average=$(echo $sum_signal / 10 | bc)
echo "Average Signal Level is: $average"
