#!/bin/bash

# Get the current battery levels
bat0=$(cat /sys/class/power_supply/BAT0/capacity) # INTERNAL
# Check if the slice battery is connected to avoid errors
if [ -d /sys/class/power_supply/BAT1/ ]; then
  bat1=$(cat /sys/class/power_supply/BAT1/capacity) # EXTERNAL
fi

# Get the charging status of each battery
status1=$(cat /sys/class/power_supply/BAT0/status)
if [ -d /sys/class/power_supply/BAT1/ ]; then
  status2=$(cat /sys/class/power_supply/BAT1/status)
fi

# Check if any of the batteries are charging
charging=false
if [ "$status1" == "Charging" ] || [ "$status2" == "Charging" ]; then
  charging=true
fi

# Get the AC adapter status
ac_status=$(cat /sys/class/power_supply/AC/online)

# This is a hacky mess
if [ -d /sys/class/power_supply/BAT1/ ]; then # Slice battery connected
  if [ "$charging" == true ] && [ "$ac_status" == 1 ]; then
    echo "%{F#1ABB9B}BATRI%{F-} +$bat1%" 
  elif [ "$charging" == false ] && [ "$ac_status" == 1 ]; then
    echo "%{F#1ABB9B}BATRI%{F-} LLAWN"
  elif [ "$bat1" -lt 16 ]; then
    while [ "$bat1" -lt 16 ]
    do
      echo "%{F#BC4028}! BATRI ISEL%{F-} $bat1%"
      sleep 0.5s
      echo "%{F#BC4028}BATRI ISEL%{F-} $bat1%"
      sleep 0.5s
    done
  else
    echo "%{F#1ABB9B}BATRI%{F-} -$bat1%"
  fi
else # If only internal battery in use
  if [ "$charging" == true ] && [ "$ac_status" == 1 ]; then
    echo "%{F#1ABB9B}BATRI%{F-} +$bat0%" 
  elif [ "$charging" == false ] && [ "$ac_status" == 1 ]; then
    echo "%{F#1ABB9B}BATRI%{F-} LLAWM"
  elif [ "$bat0" -lt 16 ]; then
    while [ "$bat0" -lt 16 ]
    do
      echo "%{F#BC4028}! BATRI ISEL%{F-} $bat0%"
      sleep 0.5s
      echo "%{F#BC4028}BATRI ISEL%{F-} $bat0%"
      sleep 0.5s
    done
  else
    echo "%{F#1ABB9B}BATRI%{F-} -$bat0%"
  fi
fi
