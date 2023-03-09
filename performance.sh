#!/usr/bin/bash

echo "Enter the server IP:"
read SERVER

echo "Connecting the server: $SERVER. ok? [y/N] "
read CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
	echo "Stopping the test"
	exit 1
fi

echo "Performance tests are starting.."
echo "Please"
echo " - Follow instructions to run server commands one by one"
echo " - Save output of server command"

BANDWIDTH=('1' '10' '25' '35' '50' '75' '100')
echo "Testing UDP with Bandwidth: ${BANDWIDTH[@]} Mbits/sec"

for i in "${BANDWIDTH[@]}";
do
	echo
	echo "Starting to test with ${i}m"
	echo "Stop running processes at the server and run this command:"
	echo "$ iperf -s -u -i 1"
	echo "ok? [y/N] "
	read CONFIRM

	if [[ "$CONFIRM" = "y" ]]; then
		echo "Testing with ${i}m."
		iperf -c $SERVER -u -t 15 -b "${i}m" > /dev/null
		echo "Collect the output at the server!"
		read CONFIRM
	else
		echo "Test is spoiled! Exiting.."
		exit 1 
	fi

done

echo
echo "UDP tests are completed. Maximum throughput test is starting."
echo "Continue.."
read CONFIRM

echo
echo "Stop the server and run it with this command (without -u):"
echo "$ iperf -s -i 1"
echo "ok? [y/N] "
read CONFIRM

if [[ "$CONFIRM" = "y" ]]; then
	echo "Maximum throughput test starting."
	iperf -c $SERVER -t 60
else
	echo "Test is spoiled! Exiting.."
	exit 1 
fi


