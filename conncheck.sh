#!/bin/bash

module="lib/$1"
echo $$ > /tmp/lbpid

function checkvnc1 {
	netstat -np tcp | grep $1 > /dev/null
	if [ "$(echo $?)" = "0" ]; then
		echo "
***NOTE***
THIS IS A LOG OF CONNECTIONS WHILE YOU WERE MONITORED
THIS DATA HOLDS INFORMATION ABOUT WHO WAS WATCHING YOU!
******

$(netstat -antp tcp)" >> /tmp/lblog
		break
	fi
}

function checkvnc2 {
netstat -np tcp | grep $1 > /dev/null
if [ "$(echo $?)" = "1" ]; then
	break
fi	
}

while true;do
	while true; do
		checkvnc1 5900
	done
	osascript $module
	while true; do
		checkvnc2 5900
	done
	osascript -e 'display dialog "The nosy librarian has left, yay!"'
	open /tmp/lblog
done