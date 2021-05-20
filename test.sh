#! /bin/bash


IP=192.168.49.25

FIRSTIP=${IP::-1}"$((${IP: -1} + 1))"

tmp=$IP
while [ ${tmp: -1} != '.' ]
do
    tmp=${tmp::-1}
done

# FIRSTIP=$tmp"$((${IP: -1} + 1))"
LASTIP=$tmp"249"


echo $IP
echo $FIRSTIP
echo $LASTIP
