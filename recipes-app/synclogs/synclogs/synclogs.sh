#!/bin/bash

PATH=${PATH}:/app/bin:/app

set -e

source obc_common.sh

if [[ $1 == "-h" ]]; then
    echo "usage: ${0} [--fin|--bb]"
    echo "syncs obd logs to $OBC_RSYNC_SHARE"
    echo "all files older than 24 hours are deleted"
    echo ""
    echo "find obc mouse version here:"
    echo "https://github.com/SEM-D-T-Team/sh-obc-outbox/blob/master/obc_environment/home/imx6/Services/synclogs.sh"
    echo ""
    echo "Datausage with no Sensors connected, Dataversion 9:"
    echo "100kB/h download, 500kb/h upload (measure with sixfab dashboard)"
    exit 1
fi

main(){
    RSYNC_INTERVALL=60
    SYNCLOGFILE=el_sync_$(date +%Y%m%d_%H%M).log

    if [[ $1 == "--fin" ]]; then
        startSyncTask obd*.log $RSYNC_INTERVALL >> $OBC_LOG_PATH/$SYNCLOGFILE 2>&1 &
    fi

    rsyncWatchdog $((${RSYNC_INTERVALL}*3)) >> $OBC_LOG_PATH/$SYNCLOGFILE 2>&1 &

    removeOldFiles 24 >> $OBC_LOG_PATH/$SYNCLOGFILE 2>&1 &
}

# Sync File /mnt/log/$1 live to Server rsync
startSyncTask(){ # filename, # sleep in sec
    FILE=$OBC_LOG_PATH/$1
    SLEEP=$2

    while true; do
        sleep $SLEEP
        rsync --compress --times --timeout=30 --append $FILE $OBC_RSYNC_SHARE/obd/
    done
}

# rsync hangs sometimes when loosing network connections
# kill it in that case, it will free the syncTask Loop
rsyncWatchdog(){ # sleep in sec
    SLEEP=$1
    pidold="0"
    pidnew="1"

    while true; do
        # check for hanging
        if [[ "$pidold" == "$pidnew" ]] && [[ -n "$pidnew" ]]; then
            echo "$(date): rsync ($pidnew) hangs, kill!"
            kill $pidnew
        fi

        # get new pid
        pidold=$pidnew
        pidnew=$(ps -e | grep rsync | awk '{print $1}')

        sleep $SLEEP
    done
}

removeOldFiles(){ # max age in hour
    maxage=$(($1*60*60))

    while true; do
        # start remove file task after 10 min
        sleep 600
        now_sec=$(date +%s)

        for file in $OBC_LOG_PATH/*; do
            lastmodification_sec=$(stat -c '%Y' ${file##*/})
            fileage_sec=$(($now_sec-$lastmodification_sec))

            if [ $fileage_sec -ge $maxage ]; then
                echo "remove ${file##*/} (age $fileage_sec sec)"
                rm $file
            fi
        done
    done
}

main "$@"
