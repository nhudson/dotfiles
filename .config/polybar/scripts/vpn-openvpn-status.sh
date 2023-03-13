#!/usr/bin/env bash

#printf "VPN: " && (pgrep -a openvpn$ | head -n 1 | awk '{print $NF }' | cut -d '.' -f 1 && echo down) | head -n 1
printf "VPN: " && (basename "$(pgrep -a openvpn | head -n 1  | awk '{print $NF}' | cut -d '.' -f 2 && echo down)") | head -n 1
