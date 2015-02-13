#!/bin/bash

function checkvnc1 {
	netstat -np tcp | grep $1 > /dev/null
	if [ "$(echo $?)" = "0" ]; then
		echo "
***NOTE***
THIS IS A LOG OF CONNECTIONS WHILE YOU WERE MONITORED
THIS DATA HOLDS INFORMATION ABOUT WHO WAS WATCHING YOU!
******

$(netstat -antp tcp)" >> /tmp/lb.log
		break
	fi
}

function checkvnc2 {
netstat -np tcp | grep $1 > /dev/null
if [ "$(echo $?)" = "1" ]; then
	break
fi	
}

function getconfarg {
	grep -v "^#" $2 | grep $1= | cut -d'=' -f 2
}

module="lib/$1"
echo $$ > /tmp/lbpid

port=$(getconfarg PORT lib/lb.conf)
osascript $module initialize

while true;do
	while true; do
		checkvnc1 $port
	done
	osascript $module go
	while true; do
		checkvnc2 $port
	done
	osascript -e 'display dialog "The nosy librarian has left, yay!"'
	open /tmp/lb.log
done
