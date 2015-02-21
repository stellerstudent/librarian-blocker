#!/bin/bash

function log {
echo "
###NOTE###
# THIS IS A LOG OF CONNECTIONS WHILE YOU WERE MONITORED
# THIS DATA HOLDS INFORMATION ABOUT WHO WAS WATCHING YOU!

$(netstat -antp tcp)" >> /tmp/lb.log
}

function checkvnc1 {
	conns="$(netstat -np tcp | grep $1 | tr -s ' ')"
	ipver="$(echo $conns | cut -d' ' -f 1)"
	if [ "$ipver" = "tcp6" ]; then
		if [ "$(echo $conns | cut -d' ' -f 4 | cut -d'.' -f 2 | grep $1 | head -n 1)" = "$1" ]; then 
			log
			break
		fi
	elif [ "$ipver" = "tcp4" ]; then
		if [ "$(echo $conns | cut -d' ' -f 4 | cut -d'.' -f 5 | grep $1 | head -n 1)" = "$1" ]; then 
			log
			break
		fi
	fi
}

function checkvnc2 {
	conns="$(netstat -np tcp | grep $1 | tr -s ' ')"
	if [ "$ipver" = "tcp6" ]; then
		if [ "$(echo $conns | cut -d' ' -f 4 | cut -d'.' -f 2 | grep $1 | head -n 1)" != "$1" ]; then 
			break
		fi		
	elif [ "$ipver" = "tcp4" ]; then
		if [ "$(echo $conns | cut -d' ' -f 4 | cut -d'.' -f 5 | grep $1 | head -n 1)" != "$1" ]; then 
			log
			break
		fi
	fi	
}

function getconfarg {
	grep -v "^#" $2 | grep $1= | cut -d'=' -f 2
}

module="lib/$1"
echo $$ > /tmp/lbpid

port=$(getconfarg PORT lib/lb.conf)
$module initialize

while true;do
	while true; do
		checkvnc1 $port
	done
	$module go
	while true; do
		checkvnc2 $port
	done
	osascript -e 'display dialog "The nosy librarian has left, yay!"'
	open /tmp/lb.log
done
