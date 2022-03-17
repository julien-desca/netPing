#!/bin/bash

#simply ping all the possible host fo the network and return the ip addresses of responding hosts
#not really usefull, made for educational purpose.
#for now, it's just work with class C network (e.g. 192.168.1.0/24), improvements comming soon.

NETWORK_IP=`echo "$1"| cut -d '/' -f 1`
NETWORK_RANGE=`echo $1|cut -d '/' -f 2`

#check arguments
if [ -z $NETWORK_IP ]
then
    echo "missing network address"
elif [ -z $NETWORK_RANGE ] 
then
    echo "missing network range"  
fi

echo "scanning network: $NETWORK_IP"
BASE_IP=`echo "$NETWORK_IP" | cut -d '.' -f 1,2,3` 

for host in `seq 1 254`; do
    ping $BASE_IP.$host -c 1 | grep "64 bytes" | cut -d ' ' -f 4 | tr -d ':' &
done
