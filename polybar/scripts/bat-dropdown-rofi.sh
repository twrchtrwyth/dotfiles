
#!/bin/bash

# Set theme and colors
rofi_theme="/usr/share/rofi/themes/acme-bat.rasi"
#rofi_bg="#2E3440"
#rofi_fg="#ECEFF4"

# Get battery information
BATTERY1=$(cat /sys/class/power_supply/BAT0/capacity) # external
BATTERY2=$(cat /sys/class/power_supply/BAT1/capacity)
STATE1=$(cat /sys/class/power_supply/BAT0/status)
STATE2=$(cat /sys/class/power_supply/BAT1/status)

# Format battery information for rofi
BATTERY_INFO="Internal: $BATTERY1% ($STATE1)\n   Slice: $BATTERY2% ($STATE2)"

# Display rofi popup with battery information
echo -e "$BATTERY_INFO" | rofi -config ~/.config/rofi/config-bat.rasi -theme "$rofi_theme" -dmenu -p "Battery Status"
