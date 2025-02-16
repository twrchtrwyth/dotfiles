#!/bin/bash

# Get the current battery levels
bat0=$(cat /sys/class/power_supply/BAT0/capacity) # INTERNAL
bat1=$(cat /sys/class/power_supply/BAT1/capacity) # EXTERNAL

# Get the wh counts of the batteries
#bat0_wh=$(($(cat /sys/class/power_supply/BAT0/energy_full_design) / 1000000))
#bat1_wh=$(($(cat /sys/class/power_supply/BAT1/energy_full_design) / 1000000))

# Define the weights for each battery capacity (in Wh?)
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
status2=$(cat /sys/class/power_supply/BAT1/status)

# Check if any of the batteries is charging
charging=false
if [ "$status1" == "Charging" ] || [ "$status2" == "Charging" ]; then
  charging=true
fi

# Battery current watt usage
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
if [ "$charging" == true ] && [ "$ac_status" == 1 ]; then
  echo "%{F#1ABB9B}BATRI%{F-} +$average%" 
elif [ "$charging" == false ] && [ "$ac_status" == 1 ]; then
  echo "%{F#1ABB9B}BATRI%{F-} -$average% AC"
elif [ "$average" -lt 16 ]; then
  echo "%{F#1ABB9B}BATRI%{F-} -$average%"
else
  echo "%{F#1ABB9B}BATRI%{F-} -$average%"
fi

