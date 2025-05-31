#!/bin/bash

latency=$(ping -c 1 -W 1 8.8.8.8 \
  | grep 'time=' \
  | sed -E 's/.*time=([0-9.]+).*/\1/' \
  || echo 9999)

# Round latency to integer
latency_int=$(printf "%.0f" "$latency")

if (( latency_int < 50 )); then
  state="good"
elif (( latency_int < 200 )); then
  state="warning"
else
  state="critical"
fi

echo "{\"text\": \"${latency} ms\", \"class\": \"$state\"}"
