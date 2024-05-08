#!/usr/bin/env python3

import datetime
import os
import pathlib
import sys

NAME = os.getenv("NAME")
FILE = "/tmp/pomo"
POMO = 25 * 60

label = ""
bg_color = "0x00000000"
file_exists = pathlib.Path(FILE).exists()

if len(sys.argv) == 2:
    arg = sys.argv[1]
    if arg == "start":
        if file_exists:
            os.remove(FILE)
            label = ""
        else:
            with open(FILE, "wt") as f:
                f.write(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
                label = "25:00"
elif file_exists:
    with open(FILE, "rt") as f:
        ts = f.read()
    start = datetime.datetime.fromisoformat(ts)
    delta = (datetime.datetime.now() - start).total_seconds()
    if delta < POMO:
        time_left = datetime.timedelta(seconds=1500 - delta).total_seconds()
        m, s = divmod(time_left, 60)
        label = f"{int(m):02}:{int(s):02}"
        # TODO: add orange too
        if time_left < 60:
            bg_color = "0xFFFF0000"
    else:
        os.remove(FILE)
        label = ""

os.system(f"sketchybar --set {NAME} label={label} background.color={bg_color}")
