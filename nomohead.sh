#!/bin/bash
# nomohead.sh
echo "Loading config..."

DIR="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"

. "${DIR}/config.cfg"

echo "Starting ngrok..."

COMMAND=("${ngrok_location}" tcp 22) 

"${COMMAND[@]}" 2> /dev/null &

IP="$(ip route get 8.8.8.8 | awk 'NR==1 {print $NF}')"

echo "Dweeting IP... "
wget --post-data="IP=${IP}" http://dweet.io/dweet/for/${dweet_id_ip} -O /dev/null

sleep $tunnel_delay

TUNNEL="$(curl http://localhost:4040/api/tunnels)"
echo "${TUNNEL}" > tunnel_info.json
TUNNEL_TCP=$(grep -Po 'tcp:\/\/([\S]*?)"' ./tunnel_info.json )

wget --post-data="tunnel=${TUNNEL_TCP}" http://dweet.io/dweet/for/${dweet_id_tunnel} -O /dev/null
