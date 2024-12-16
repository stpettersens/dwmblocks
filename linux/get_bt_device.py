#!/bin/env python3
from os import path
from itertools import count
from subprocess import check_output, CalledProcessError

def get_bt_device() -> None:
    if path.exists('/ramdisk/bluetooth_off'):
        print('[DISABLED]')
        return

    split_info: list[str] = []
    try:
        info: str = check_output("bluetooth_devices", shell=True, text=True)
        split_info = info.split('\n')
        split_info.pop()

    except CalledProcessError:
        print('[NO RECEIVER]')
        return

    devices: list[str] = []
    for index in count(start=0, step=2):
        if index == len(split_info):
            break

        d = split_info[index].split('Name:')[1].strip()
        d += '='
        d += split_info[index+1].split('Connected:')[1].strip()
        devices.append(d)

    device: str = '[NONE]'
    for bt in devices:
        btd = bt.split('=')
        if btd[1] == 'yes':
            device = '[{}]'.format(btd[0])

    print(device)

if __name__ == "__main__":
    get_bt_device()
