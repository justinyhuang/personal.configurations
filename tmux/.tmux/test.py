#!/usr/bin/env python
import curses
windowObject= curses.initscr()
windowObject.addstr(10,20,"That's all Folks!")
windowObject.refresh()
windowObject.getch()
curses.endwin()
