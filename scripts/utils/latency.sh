#!/bin/bash

if true; then
  echo '{"text": "", "class": "disabled"}'
  exit 0
fi

# Perform the ping
ping_output=$(ping -c 1 -W 1 8.8.8.8 2>/dev/null)
if [[ $? -eq 0 ]]; then
  latency=$(echo "$ping_output" | grep 'time=' | sed -E 's/.*time=([0-9.]+).*/\1/')
else
  latency="9999"
fi

# Round latency to nearest integer
latency_int=$(printf "%.0f" "$latency")

# Determine latency class
if (( latency_int < 50 )); then
  state="good"
elif (( latency_int < 200 )); then
  state="warning"
else
  state="critical"
fi

# Output JSON for Waybar
echo "{\"text\": \"${latency} ms\", \"class\": \"$state\"}"
