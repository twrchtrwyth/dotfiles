#!/bin/bash

# Get the current battery levels
bat0=$(cat /sys/class/power_supply/BAT0/capacity) # INTERNAL
# Only check for this if the slice battery is connected to avoid errors
if [ -d /sys/class/power_supply/BAT1/ ]; then
  bat1=$(cat /sys/class/power_supply/BAT1/capacity) # EXTERNAL
fi

# Get the Wh counts of the batteries
# Commented out as the name of the file seems to change randomly
#bat0_wh=$(($(cat /sys/class/power_supply/BAT0/energy_full_design) / 1000000))
#bat1_wh=$(($(cat /sys/class/power_supply/BAT1/energy_full_design) / 1000000))

# Define the weights for each battery capacity
weight1=24  # internal
weight2=72  # external 

# Determine the calculation method based on wh values
if [[ "$bat0_wh" -le 25 && "$bat1_wh" -le 25 ]]; then
  average=$(( (bat0 + bat1) / 2 ))
else
  total_weight=$((weight1 + weight2))
  average=$(( (bat0 * weight1 + bat1 * weight2) / total_weight ))
fi

# Get the charging status of each battery
status1=$(cat /sys/class/power_supply/BAT0/status)
if [ -d /sys/class/power_supply/BAT1/ ]; then
  status2=$(cat /sys/class/power_supply/BAT1/status)
fi

# Check if any of the batteries is charging
charging=false
if [ "$status1" == "Charging" ] || [ "$status2" == "Charging" ]; then
  charging=true
fi

# Battery current watt usage
# Commented out as per Wh counts above
#if [ $(cat /sys/class/power_supply/BAT1/current_now) -eq 0 ]; then
#  bat_watt=$(echo "scale=2; $(cat /sys/class/power_supply/BAT0/current_now)*$(cat /sys/class/power_supply/BAT0/voltage_now)/1000000000000" | bc)W
#else
#  bat_watt=$(echo "scale=2; $(cat /sys/class/power_supply/BAT1/current_now)*$(cat /sys/class/power_supply/BAT1/voltage_now)/1000000000000" | bc)W
#fi

# Get the AC adapter status
ac_status=$(cat /sys/class/power_supply/AC/online)

# Select battery icon dynamically
#if [ "$average" -le 10 ]; then
#  battery_icon="" # Empty
#elif [ "$average" -le 30 ]; then
#  battery_icon="" # Low
#elif [ "$average" -le 60 ]; then
#  battery_icon="" # Medium
#elif [ "$average" -le 90 ]; then
#  battery_icon="" # High
#else
#  battery_icon="" # Full
#fi

# Output the battery levels, charging status, and AC adapter status
# add %bat_watt if you want to see current usage
# This is a hacky mess
if [ -d /sys/class/power_supply/BAT1/ ]; then
  if [ "$charging" == true ] && [ "$ac_status" == 1 ]; then
    echo "%{F#1ABB9B}BATRI%{F-} +$average%" 
  elif [ "$charging" == false ] && [ "$ac_status" == 1 ]; then
    echo "%{F#1ABB9B}BATRI%{F-} LLAWN"
  elif [ "$average" -lt 16 ]; then
    while [ "$average" -lt 16 ]
    do
      echo "%{F#BC4028}! BATRI ISEL%{F-} $average%"
      sleep 0.5s
      echo "%{F#BC4028}BATRI ISEL%{F-} $average%"
      sleep 0.5s
    done
  else
    echo "%{F#1ABB9B}BATRI%{F-} -$average%"
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
