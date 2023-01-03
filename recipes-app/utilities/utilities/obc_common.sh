#!/bin/bash

# LogPaths
OBC_LOG_PATH=/mnt/log/
OBC_SYS_LOG_PATH=/mnt/log/system.log

# local obc config file
OBC_OBCCONF_FILE=/app/conf/obc.cnf
OBC_ERROR_CONF_FILE=/app/conf/obd_error.json
OBC_CA_FILE=/app/conf/ca.crt

#functions
getTeamNo(){
    cat $OBC_OBCCONF_FILE | grep TeamNo | cut -d= -f2 | head -n1
}

getRsyncShare(){
    cat $OBC_OBCCONF_FILE | grep ip_log | cut -d= -f2 | head -n1
}

getUpdateSrc(){
    cat $OBC_OBCCONF_FILE | grep ip_update | cut -d= -f2 | head -n1
}

getIotIp(){
    cat $OBC_OBCCONF_FILE | grep ip_broker | cut -d= -f2 | head -n1
}

getUseWifi(){
    cat $OBC_OBCCONF_FILE | grep use_wifi | cut -d= -f2 | head -n1
}

# Server IP, Folders
OBC_RSYNC_SHARE=$(getRsyncShare)

# print PID of arg $1
printAllPid(){
    if [[ $(ps -e | grep $1 | wc -l) -gt 1 ]]; then
        echo "WARNING: multiple Instances started"
    fi
    echo "$1 PID: ($( ps -e | grep $1 | awk '{print $1}' | tr '\n' ','))"
}
