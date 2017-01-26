#!/bin/bash

TITLE="NET STATUS IS RUNNING..."

COL_GREEN="\x1b[7;49;32m"
GREEN_RESET="\x1b[39;49;00m"
COL_RED="\x1b[7;49;31m"
RED_RESET="\x1b[39;49;00m"
COL_GREY="\x1b[0;49;90m"
GREY_RESET="\x1b[39;49;00m"

echo -e $COL_GREEN'\033k '$TITLE' \033\\'$GREEN_RESET

is_up=false

while true
do
	# stores date and time
	now=$(date)
	# gets index.html, but overwrites (-N) so not creating multiple files
	wget -N -q --tries=10 --timeout=20 http://google.com
	# $? outputs 0: why?
	if [[ $? -eq 0 ]]; then
		if [ "$is_up" = false ]; then
			say -v "Serena" "Internet up"
			is_up=true
		fi
        echo -e $COL_GREY"NET: "$GREY_RESET$COL_GREEN" UP "$GREEN_RESET" - "$COL_GREY"$now"$GREY_RESET
	else
		if [ "$is_up" = true ]; then
			#afplay scream.mp3
			say -v "Serena" "Internet down"
        	echo "NET DOWN - $now" >> log.txt
		fi
		if [ "$is_up" = false ]; then
			say -v "Daniel" "o"
        	#echo "NET DOWN - $now" >> log.txt
		fi
		is_up=false
        echo -e $COL_GREY"NET: "$GREY_RESET$COL_RED" DO "$RED_RESET" - $now"
	fi
	sleep 10
done