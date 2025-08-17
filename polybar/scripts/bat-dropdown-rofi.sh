
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
# -d checks if a dir exists
if [ -d /sys/class/power_supply/BAT1/ ]; then # BAT1 = external battery
	BATTERY_INFO="Mewnol: $BATTERY1% ($STATE1)\n Sleis: $BATTERY2% ($STATE2)"
else
	BATTERY_INFO="Mewnol: $BATTERY1% ($STATE1)\n Sleis: NOT CONNECTED"
fi

# Display rofi popup with battery information
echo -e "$BATTERY_INFO" | rofi -config ~/.config/rofi/config-bat.rasi -theme "$rofi_theme" -dmenu -p "Statws Batri"
