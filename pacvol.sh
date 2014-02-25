#!/bin/sh

# Alsa Volume Control Script

SINK=0
STEP=1
MAXVOL=100
MUTED=0
#VOLPERC=`pactl list sinks | awk '/Volume: 0:/ {print substr($3, 1, index($3, "%") - 1)}' | head -n1`
VOLPERC=`amixer get Master | grep "Mono:" | awk '{print $4}' | tr -d '[]%'`
SKIPOVERCHECK=1

display(){
  if [ "$MUTED" = "yes" ]; then
    echo "🔇  muted"
  elif [ "$VOLPERC" -lt 33 ]; then
    echo "🔈 ${VOLPERC}%"
  elif [ "$VOLPERC" -lt 66 ]; then
    echo "🔉 ${VOLPERC}%"
  else
    echo "🔊 ${VOLPERC}%"
  fi
}

up()
{
	amixer set Master 1dB+ > /dev/null
}

down(){
	amixer set Master 1dB- > /dev/null
}

max(){
	amixer set Master $MAXVOL > /dev/null
}

min(){
	amixer set Master 0 > /dev/null
}

mute(){
	amixer set Master mute > /dev/null
}

unmute(){
	amixer set Master unmute > /dev/null
}

toggle(){
	M=`amixer get Master | grep "Mono:" | awk '{print $6}' | tr -d '[]'`
	if [ $M == "on" ]; then
		mute;
	else
		unmute;
	fi
}

case $1 in
up)
	up;;
down)
	down;;
max)
	max
	exit 0;;
min)
	min
	exit 0;;
toggle)
	toggle
	exit 0;;
mute)
	mute;
	exit 0;;
unmute)
	unmute;
	exit 0;;
display)
	display;
	exit 0;;
*)
	echo "Usage: `basename $0` [up|down|min|max|overmax|toggle|mute|unmute|display]"
	exit 1;;
esac