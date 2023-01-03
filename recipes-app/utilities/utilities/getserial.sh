#!/bin/bash

OPTIND=1         # Reset getopts

# read commandline options
while getopts "hfB" opt; do
    case "$opt" in
    f)  OBCSerialNo=$(cat /app/conf/serialfin.csv | grep $(cat /sys/class/net/eth0/address) | cut -d';' -f1)
        ;;
    B)  # wait for network if nececary
        mac=$(arp -an | awk '/192.168.1.110/{print $4;exit}' | wc -l)
        while [ $mac -eq 0 ]
        do 
            sleep 1
            mac=$(arp -an | awk '/192.168.1.110/{print $4;exit}' | wc -l)
        done
        OBCSerialNo=$(cat /app/conf/serialbb.csv | grep $(arp -an | awk '/192.168.1.110/{print $4;exit}') | cut -d';' -f1)
        ;;
    *)
        echo "usage: ./$(basename $0) -hbfBF"
        echo "gets serial number of device"
        echo "    -f get serial Fin"
        echo "    -B get serial from remote Backbone"
        echo "    -h show help"
        exit 1
        ;;
   esac
done

echo "${OBCSerialNo}"
