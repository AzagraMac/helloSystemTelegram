#!/bin/bash

TOKEN_BOT="YOUR_TOKEN_BOT"
TOKEN_ID="YOUR_TOKEN_CHAT"
URL="https://api.telegram.org/bot$TOKEN_BOT/sendMessage"
MSG="\U1F40D NanoPi NEO2, online!"
DNS="1.1.1.1"
LOCAL_IP=$(ip route get $DNS | grep src| sed 's/.*src \(.*\)$/\1/g' | awk '{print $1}')
PUBLIC_IP=$(curl http://checkip.amazonaws.com)
cpu=$(cat /sys/class/thermal/thermal_zone0/temp)
FREERAM=$(free -mh | grep Mem | awk '{print $4}')
TOTALRAM=$(free -mh | grep Mem | awk '{print $2}')

/usr/bin/ping -c2 $DNS > /dev/null 2>&1
if [ $? -ne 0 ]
then
        exit 0
else
        /usr/bin/curl -s -X POST $URL \
		-d chat_id=$TOKEN_ID \
		-d parse_mode=HTML \
		-d text="$(printf "$MSG<code>\n\t\t- CPU temp: $((cpu/1000))°\n\t\t- RAM: Free $FREERAM/ Total $TOTALRAM\n\t\t- IP address: $LOCAL_IP\n\t\t- IP public: $PUBLIC_IP</code>")" \
		> /dev/null 2>&1
        exit 0
fi