#!/bin/sh

POWEROPTI_LOCAL_IP="192.168.0.XX"

case $1 in
  latest_data)
  var=$(curl -s -f "http://$POWEROPTI_LOCAL_IP/rpc" \
        -H "Accept-Charset: UTF-8" \
        -H "Connection: close" \
        -H "Content-Type: application/json" \
        -H "Host: 192.168.86.32" \
        -H "Accept-Encoding: gzip" \
        -d '{"id":1,"jsonrpc":"2.0","method":"getConfig","params":{"key":"latest_data"}}'
        )
  status="$?"
  echo "${var}" | jq;
  exit "$status"
;;
  data)
  var=$(poweropti latest_data | jq -r .result)
  var=$(echo $var | base64 --decode)
  echo "$var" | jq
;;
  grid)
  var=$(poweropti data | jq -r '.[1].d[0].v')
  echo "$var"
;;
*)
  echo >&2 "The argument for the desired meter value is missing or invalid"
  exit 1
  ;;
esac