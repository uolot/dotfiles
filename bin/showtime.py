#!/usr/bin/env python3

import datetime
import tkinter


class Window(tkinter.Frame):
    def __init__(self, master=None):
        tkinter.Frame.__init__(self, master, bg="black")
        self.master = master
        self.init_window()

    def init_window(self):
        self.master.title("showtime")
        self.pack(fill=tkinter.BOTH, expand=1)

        font_name = "Bitstream Vera Sans"
        colors = {"fg": "white", "bg": "black"}

        self.time_label = tkinter.Label(self, text="", font=(font_name, 60), **colors)
        self.time_label.pack()

        self.date_label = tkinter.Label(self, text="", font=(font_name, 20), **colors)
        self.date_label.pack()

        self.update()

        self.bind("<KeyRelease>", self.keyup)
        self.focus_set()

    def keyup(self, e):
        if e.keysym.lower() in ["q", "escape", "space"]:
            print("Quit!")
            self.client_exit()

    def update(self):
        now = datetime.datetime.now()
        time = now.strftime("%H:%M:%S")
        date = now.strftime("%A, %d %B")

        self.time_label["text"] = time
        self.date_label["text"] = date

        self.after(100, self.update)

    def client_exit(self):
        exit(0)


if __name__ == "__main__":
    root = tkinter.Tk()
    app = Window(root)
    root.mainloop()
