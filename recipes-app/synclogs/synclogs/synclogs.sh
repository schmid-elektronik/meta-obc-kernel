#!/bin/bash

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/app/bin:/app
set -e

source obc_common.sh

FILE=${OBC_LOG_PATH}/obd_*log

# just sync obd file
while true; do
        # WORKAROUND, rsync only works when dns in place and wifi up
        sleep 90
	echo $(date) >> /mnt/log/rsync.log
	rsync --timeout=30 --append $FILE $OBC_RSYNC_SHARE/obd/
done

