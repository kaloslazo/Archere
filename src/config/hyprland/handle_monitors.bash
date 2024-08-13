#!/bin/bash

# Detecta si los monitores externos están conectados
HDMI_CONNECTED=$(hyprctl monitors | grep -c "HDMI-A-1")
DP_CONNECTED=$(hyprctl monitors | grep -c "DP-2")

# Configura los monitores dependiendo de las conexiones
if [ $HDMI_CONNECTED -eq 1 ] || [ $DP_CONNECTED -eq 1 ]; then
    hyprctl dispatch exec "hyprctl keyword monitor 'eDP-1,disable'"
else
    hyprctl dispatch exec "hyprctl keyword monitor 'eDP-1,1920x1200@60,0x0,1'"
fi

