#!/usr/bin/env python3
import time
"""
90 "hex hours" in a day
Each of which is 16 standard minutes
Which equals 64 "hex minutes" of 15 seconds each
This differs from the Python folder hex clock which uses standard minutes.
"""

def clock():
    now = time.localtime()
    minutes_elapsed = now[3] * 60 + now[4]
    seconds_elapsed = minutes_elapsed * 60 + now[5]
    hours = minutes_elapsed // 16
    minutes = (seconds_elapsed - hours * 16 * 60) // 15
    hours = hex(int(hours)).replace("0x", "").zfill(2)
    minutes = hex(int(minutes)).replace("0x", "").zfill(2)

    print(f"{hours}:{minutes}")

clock()
