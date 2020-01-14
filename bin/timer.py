#!/usr/bin/env python3

import sys
import time

import tkinter


def nth(xs, n, default=None):
    try:
        return xs[n]
    except IndexError:
        return default


class Time:
    def __init__(self, h, m, s):
        self.h = int(h)
        self.m = int(m)
        self.s = int(s)

    @classmethod
    def from_str(cls, s):
        *hs, m, s = map(int, s.split(":"))
        h = nth(hs, 0, 0)
        return cls(h, m, s)

    @classmethod
    def from_seconds(cls, t):
        m, s = divmod(t, 60)
        h, m = divmod(m, 60)
        return cls(h, m, s)

    def to_seconds(self):
        return self.s + self.m * 60 + self.h * 3600

    def __str__(self):
        return f"{self.h}:{self.m:>02}:{self.s:>02}"

    def __repr__(self):
        return f"<Time: {str(self)}>"


class Timer:
    def __init__(self, duration: int):
        self.duration = duration
        self.started = 0

    def start(self):
        self.started = time.time()  # type: ignore

    @classmethod
    def from_str(cls, time_str):
        return cls(Time.from_str(time_str).to_seconds())

    @property
    def passed(self):
        return int(time.time() - self.started)

    @property
    def left(self):
        return max(self.duration - self.passed, 0)

    @property
    def finished(self):
        return self.left == 0

    def __str__(self):
        return str(Time.from_seconds(self.left))

    def __repr__(self):
        return f"<Timer: {str(self)}>"


class Window(tkinter.Frame):
    def __init__(self, duration: str, master=None):
        tkinter.Frame.__init__(self, master, bg="black")
        self.master = master
        self.timer = Timer.from_str(duration)
        self.timer.start()
        self.init_window()

    def init_window(self):
        self.master.title("timer")
        self.pack(fill=tkinter.BOTH, expand=1)

        font_name = "Bitstream Vera Sans"
        colors = {"fg": "white", "bg": "black"}

        self.time_label = tkinter.Label(self, text="", font=(font_name, 30), **colors)
        self.time_label.pack()

        self.update()

        self.bind("<KeyRelease>", self.keyup)
        self.focus_set()

    def keyup(self, e):
        if e.keysym.lower() in ["q", "escape", "space"]:
            print("Quit!")
            self.client_exit()

    def update(self):
        self.time_label["text"] = str(self.timer)

        self.after(100, self.update)

    def client_exit(self):
        exit(0)


if __name__ == "__main__":
    root = tkinter.Tk()
    app = Window(sys.argv[1], root)
    root.mainloop()
