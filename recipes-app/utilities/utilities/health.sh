#!/bin/bash

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/app/bin:/app
set -e

source obc_common.sh

BOOT=$(date +%s)

# WORKAROUND, wait for wifi
sleep 30 

while true; do
	sleep 60
	
	IP=$(ip addr show wlan0 | grep inet | head -1 |awk '{print $2}' | cut -f1  -d'/')
	TEAM=$(getTeamNo)
	NOWTIME=$(date +%s)

	mosquitto_pub -h activemq.sem-app.com -p 8883 -t "device/mqtt/health/${TEAM}" -m "{\"cnf_bb\":\"0\",\"cnf_obc\":\"0\",\"e_sens\":\"ALL\",\"e_type\":\"\",\"ip_broker\":\"\",\"ip_conf\":\"${IP}\",\"ip_log\":\"\",\"o_cpu\":\"0\",\"o_disk\":\"0\",\"o_fw\":\"\",\"o_ram\":\"0\",\"o_sw\":\"\",\"o_temp\":\"\",\"sn_bb\":\"0\",\"sn_obc\":\"0\",\"t_boot\":\"${BOOT}\",\"t_conf\":\"1649083724\",\"t_now\":\"${NOWTIME}\",\"t_rate\":\"\",\"t_up\":\"\"}" --cafile /app/conf/ca.crt
done
	
