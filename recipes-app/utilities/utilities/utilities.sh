#!/bin/bash

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/app/bin:/app
set -e

source obc_common.sh

dmesg -w >> $OBC_LOG_PATH/dmesg_$(date +%Y-%m-%d_%H-%m-%S).log & 
