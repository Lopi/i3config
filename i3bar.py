#!/usr/bin/env python

import subprocess
import sys
import json

conkyrc="/home/lopi/.conkyrc"



print('{"version":1, "click_events": true }')
print('[')
print('[],')
sys.stdout.flush()
subprocess.Popen(["conky","-c", conkyrc])


class Item:
    commands={}
    processes={}
    def __init__(self, commands):
        self.commands=commands
        self.processes={}
    def execute(self,button):
        if button in self.commands:    
            self.processes[button]=subprocess.Popen(self.commands[button],stdout=subprocess.DEVNULL)
    def kill(self,button):
        self.processes[button].kill()
    def is_running(self,button):
        if button not in self.processes:
            return False
        process=self.processes[button]
        
        if process.poll()==None:
            return True
        return False

    def toggle(self,button):
        if self.is_running(button):
            self.kill(button)
        else:
            self.execute(button)


items={}
items["cpu"]=Item(
            {
                1:["xfce4-terminal", "-H", "--command", "htop", "-T", "Process Monitor", "--geometry=100x30+1115+45"]
            }
        )
items["volume"]=Item(
            {
                1:["zsh", "/home/lopi/.scripts/volume.sh"],
            }
        )
items["date"]=Item(
            {
                1:["yad", "--no-buttons", "--geometry=++1650+25", "--class", "YADWIN", "--calendar"]
            }
        )
items["updates"]=Item(
            {
                1:["zsh", "/home/lopi/.scripts/update.sh"]
            }
        )
items["netdown"]=Item(
            {
                1:["xfce4-terminal", "-H", "--command", "iftop -P -b -l -B", "-T", "Network Monitor", "--geometry=100x30+1115+45"]
            }
        )
items["netup"]=Item(
            {
                1:["xfce4-terminal", "-H", "--command", "iftop -P -b -l -B", "-T", "Network Monitor", "--geometry=100x30+1115+45"]
            }
        )

items["uptime"]=Item(
            {
                1:["xfce4-terminal", "-H", "--command", "archey", "-T", "System Information", "--geometry=80x20+1272+45"]
            }
        )


for i in sys.stdin:
    if i=="[\n":
        continue
    clickevent=json.loads(i.strip(','))
    name=clickevent["name"]
    button=clickevent["button"]

    if name in items:
        item=items[name]
        item.toggle(button)
