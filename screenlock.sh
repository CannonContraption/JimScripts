#!/bin/bash

#Enter image paths here.
SINGLESCREEN=/path/to/single/screen/image
DUALSCREEN=/path/to/dual/screen/image

xrandr | grep -v 'disconnected' > /dev/shm/xrandroutput.txt
FULLSIZE=$(cat /dev/shm/xrandroutput.txt | grep "Screen 0" | grep -E -o '[0-9]+ x [0-9]+' | head -2 | tail -1)
NUMSCREENS=$(cat /dev/shm/xrandroutput.txt | grep 'connected' | wc -l)
if [ $NUMSCREENS = 2 ]; then
	S2OFFSET=$(cat /dev/shm/xrandroutput.txt | grep "connected" | grep -E -o '\+[0-9]+\+' | grep -E -o [0-9]+ | tail -1)
else
	S2OFFSET=0
fi
FULLY=$(echo $FULLSIZE | grep -m 1 -E -o '[0-9]+ ')
scrot /dev/shm/i3lock-temp.png
convert -scale 5% -scale 2000% /dev/shm/i3lock-temp.png /dev/shm/i3lock-current.png
convert -blur 10x10 /dev/shm/i3lock-current.png /dev/shm/i3lock-temp.png
if [ $(($FULLY / 2)) = $S2OFFSET ]; then
	convert /dev/shm/i3lock-temp.png $DUALSCREEN -gravity center -composite -matte /dev/shm/i3lock-current.png
else
	convert /dev/shm/i3lock-temp.png $SINGLESCREEN -gravity center -composite -matte /dev/shm/i3lock-current.png
fi
convert -dither FloydSteinberg -colors 8 /dev/shm/i3lock-current.png /dev/shm/i3lock-temp.png
cp /dev/shm/i3lock-temp.png /dev/shm/i3lock-current.png
rm /dev/shm/i3lock-temp.png
i3lock -i /dev/shm/i3lock-current.png
rm /dev/shm/i3lock-current.png

