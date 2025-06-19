#!/bin/env python3
import os

def get_picom_status():
    status = '[PICOM ON]'
    if os.path.exists('/ramdisk/picom_off'):
        status = '[PICOM OFF]'

    print(status)

if __name__ == "__main__":
    get_picom_status()
