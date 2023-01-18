#!/bin/bash

LOG=/mnt/log/el_wlan_$(date +%Y%m%d_%H%M).log

echo ======================= >> ${LOG}
echo $(date) >> ${LOG}

while [ $(lsusb | grep Cypress | wc -l) -eq 0 ]; do
    sleep 1
    echo "wait for interface"  >> ${LOG}
done

sleep 2

# starting wifi manually is an ugly workaround..
# do it with udev, ifplugd, or wire the module on the SDIO interface
ifup wlan0 >> ${LOG} 2>&1

# udev get devinfo 
# udevadm info -ap /devices/platform/soc/5800c000.usbh-ohci/usb1/1-1/1-1.2/1-1.2.1
# udevadm monitor --kernel --property 

# rules that are supposed to work..
#ACTION="add", ATTR{product}=="Cypress USB 802.11 Wireless Adapter", RUN+="/root/startwifi.sh"
#ACTION="add, ATTR{idProduct}=="0bdc", RUN+="/root/startwifi.sh"
#ACTION=="add", SUBSYSTEM=="usb", ENV{PRODUCT}=="4b4/bdc/1", RUN=="/root/startwifi.sh"
