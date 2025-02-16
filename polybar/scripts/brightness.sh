#!/bin/bash

# Automatically determine the backlight device
BACKLIGHT_DEVICE=$(brightnessctl --list | grep -B 1 "class 'backlight'" | grep "Device" | cut -d "'" -f 2)

# Check if a valid backlight device was found
if [ -z "$BACKLIGHT_DEVICE" ]; then
    echo "No backlight device found. Please ensure you have a supported backlight device."
    exit 1
fi

# Maximum brightness level for your screen
MAX_BRIGHTNESS=$(brightnessctl --device="$BACKLIGHT_DEVICE" max)

# Check if brightnessctl is installed
if ! command -v brightnessctl &> /dev/null; then
    echo "brightnessctl not found. Please install it."
    exit 1
fi

# Get the current brightness value in percentage
get_brightness_percent() {
    brightness_info=$(brightnessctl --device="$BACKLIGHT_DEVICE")
    current_percentage=$(echo "$brightness_info" | grep -oE '[0-9]+%')
    echo "BL: $current_percentage"
}

get_brightness() {
    brightnessctl --device="$BACKLIGHT_DEVICE" get
}

# Set brightness to a specific percentage
set_brightness() {
    percentage=$1
    brightness_value=$((MAX_BRIGHTNESS * percentage / 100))
    brightnessctl --device="$BACKLIGHT_DEVICE" set "$brightness_value"
}

# Increase brightness by 5%
increase_brightness() {
    brightnessctl --device="$BACKLIGHT_DEVICE" set 5%+
}

# Decrease brightness by 5%
decrease_brightness() {
    brightnessctl --device="$BACKLIGHT_DEVICE" set 5%-
}

# Handle Polybar events
case "$1" in
    "up")
        increase_brightness
        ;;
    "down")
        decrease_brightness
        ;;
    "max")
        set_brightness 100
        ;;
    "min")
        set_brightness 0
        ;;
    "get")
        get_brightness_percent
        ;;
esac
