#!/bin/bash

#simply ping all the possible host fo the network and return the ip addresses of responding hosts
#not really usefull, made for educational purpose.
#improvements comming soon (or not).

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

# convert address to binary
BINARY_ADDRESS=''
for i in `seq 1 4`; do
    b=''
    DECIMAL=`echo $NETWORK_IP | cut -d '.' -f $i`
    while [ "$DECIMAL" -gt 1 ]
    do
	b+=$(("$DECIMAL"%2))
	DECIMAL=$(("$DECIMAL"/2))	
    done
    b+="$DECIMAL"
    BINARY_ADDRESS+=`echo "$b"|rev`
    BINARY_ADDRESS+='.'
done
BINARY_ADDRESS=${BINARY_ADDRESS%?}
echo "Binary address: $BINARY_ADDRESS"


echo "scanning network: $NETWORK_IP"

BASE_IP=`echo "$NETWORK_IP" | cut -d '.' -f 1,2,3`

for host in `seq 1 254`; do
    ping $BASE_IP.$host -c 1 | grep "64 bytes" | cut -d ' ' -f 4 | tr -d ':' &
done
