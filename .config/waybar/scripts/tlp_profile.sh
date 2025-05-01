#!/bin/bash

# Detect current profile
STATUS=$(tlp-stat -s | grep "Mode" | awk '{print $3}')

case "$1" in
  toggle)
    if [[ "$STATUS" == "AC" ]]; then
      sudo tlp bat
      echo "Switched to BAT"
    else
      sudo tlp ac
      echo "Switched to AC"
    fi
    ;;
  *)
    echo "TLP: $STATUS"
    ;;
esac

