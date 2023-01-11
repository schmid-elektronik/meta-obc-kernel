#!/bin/sh
### BEGIN INIT INFO
# Provides:          utilities
# Required-Start:    $network
# Required-Stop:     $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description:
# Description:
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/app/bin:/app
DESC=synclogs.sh
set -e

source obc_common.sh

case $1 in
  start)
        ${DESC}
  ;;
  status)
        ps -e | grep rsync
   ;;
   *)
        echo "Usage: ${DESC} {start|status}" >&2
        exit 1
        ;;
esac

exit 0

# vim:noet
