#!/bin/bash

REMUSB_HOST=${REMUSB_HOST:-remusb}
REMLAN_HOST=${REMLAN_HOST:-remlan}

REMUSB_IP=$(awk '/^host '"$REMUSB_HOST"'$/{x=1}x&&/Hostname/{print $2;exit}' ~/.ssh/config)
REMLAN_IP=$(awk '/^host '"$REMLAN_HOST"'$/{x=1}x&&/Hostname/{print $2;exit}' ~/.ssh/config)

USB_OK=`/sbin/arp -a | grep -i $REMUSB_IP`
LAN_OK=`/sbin/arp -a | grep -i $REMLAN_IP`

echo 'Trying USB interface('"$REMUSB_IP"')...'

if [ -z "$USB_OK" ]
then
	echo "Remarkable not found on USB"
	echo 'Trying LAN interface('"$REMLAN_IP"')...'

	if [ -z "$LAN_OK" ]
	then
        	echo "Remarkable not found on LAN"
	else
        	echo "SUCCESS: Remarkable found on LAN"
        	ssh $REMLAN_HOST
	fi

else
	echo "SUCCESS: Remarkable found on USB"
	ssh $REMUSB_HOST
fi


