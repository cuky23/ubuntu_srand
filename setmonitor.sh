#/bin/bash
MODE="1920x1080"
MONITORS=$(xrandr --listactivemonitors |awk '{print$4}'|grep -v ^$ |xargs)
PRIMARY=""
REST=""
for mon in $MONITORS
do
	echo "mon $mon"
	if [[ "X" = "X${PRIMARY}" ]] ; then
		PRIMARY="$mon"
		PART1="--output $PRIMARY --mode $MODE "
	else 
		REST="$REST $mon"
	fi	
	export PART1
	export REST
done
#xrandr --output HDMI-1-2 --mode 1920x1080 --output  HDMI-0 --mode 1920x1080 --same-as HDMI-1-2 --output  HDMI-1-1 --mode 1920x1080 --same-as HDMI-1-2
PART2=$(for r in $REST 
do
	echo "--output $r --mode $MODE --same-as $PRIMARY "
done |xargs )
echo "xrandr --output HDMI-1-2 --mode 1920x1080 --output HDMI-0 --mode 1920x1080 --same-as HDMI-1-2 --output HDMI-1-1 --mode 1920x1080 --same-as HDMI-1-2"
echo "xrandr $PART1 $PART2"
xrandr $PART1 $PART2
xrandr --listactivemonitors
