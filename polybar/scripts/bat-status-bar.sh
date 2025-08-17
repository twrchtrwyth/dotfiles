#!/bin/bash

# Get the current battery levels
bat0=$(cat /sys/class/power_supply/BAT0/capacity) # INTERNAL
# Check if the slice battery is connected to avoid errors
if [ -d /sys/class/power_supply/BAT1/ ]; then
  bat1=$(cat /sys/class/power_supply/BAT1/capacity) # EXTERNAL
fi

# Get the charging status of each battery
status0=$(cat /sys/class/power_supply/BAT0/status)
if [ -d /sys/class/power_supply/BAT1/ ]; then
  status1=$(cat /sys/class/power_supply/BAT1/status)
fi

# Check if any of the batteries are charging
charging0=false
charging1=false
if [ "$status0" == "Charging" ]; then
  charging0=true
elif [ "$status1" == "Charging" ]; then
  charging1=true
fi

# Get the AC adapter status
ac_status=$(cat /sys/class/power_supply/AC/online)

# Show stats for the slice battery if connected and has charge
if [ -d /sys/class/power_supply/BAT1/ ] && [ "$bat1" -gt 0 ]; then
  if [ "$charging1" == true ] && [ "$ac_status" == 1 ]; then
    echo "%{F#1ABB9B}SLEIS%{F-} +$bat1%"
  # If AC connected but neither battery is charging, they are both full
  elif [ "$charging0" == false ] && [ "$charging1" == false ] && [ "$ac_status" == 1 ]; then
    echo "%{F#1ABB9B}BATRIS%{F-} LLAWN"
  # If the internal battery is charging, show that instead
  elif [ "$charging0" == true ] && [ "$charging1" == false ] && [ "$ac_status" == 1 ]; then
    echo "%{F#1ABB9B}BATRI%{F-} +$bat0%"
  # If slice battery is low then show warning in red
  elif [ "$bat1" -lt 16 ]; then
    echo "%{F#BC4028}SLEIS ISEL%{F-} -$bat1%"
  # Otherwise the slice battery is discharging
  else
    echo "%{F#1ABB9B}SLEIS%{F-} -$bat1%" 
  fi
# If no slice battery connected or it is dead, show status of internal battery
else
  if [ "$charging0" == true ] && [ "$ac_status" == 1 ]; then
    echo "%{F#1ABB9B}BATRI%{F-} +$bat0%" 
  elif [ "$charging0" == false ] && [ "$charging1" == false ] && [ "$ac_status" == 1 ]; then
    echo "%{F#1ABB9B}BATRI%{F-} LLAWN"
  elif [ "$bat0" -lt 16 ]; then
    echo "%{F#BC4028}BATRI ISEL%{F-} -$bat0%"
  else
    echo "%{F#1ABB9B}BATRI%{F-} -$bat0%" 
  fi
fi
