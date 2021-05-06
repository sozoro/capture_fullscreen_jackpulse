#!/usr/bin/env bash
jackClient="capture_full_pulse"
PulseAudioJackSink="PulseAudio JACK Sink-$UID"
out="`date +%Y%m%d_%H:%M:%S`.mp4"
queSize=1024

DISPLAY=`ps -aux \
       | sed -n -r "s/^$USER.*xinit.*(:[0-9]+).*$/\1/p" \
       | fzf --layout=reverse --height=10% --prompt "select \\$DISPLAY to capture > "`
if [ -z "$DISPLAY" ]; then
  echo DISPLAY is not selected.
  exit 1
else
  export DISPLAY
  echo DISPLAY=$DISPLAY
fi

full=`xrandr | grep \* | awk '{print $1}'`
ffmpeg -s $full -f x11grab -i $DISPLAY -f jack -thread_queue_size $queSize -i $jackClient -vcodec libx264 -preset ultrafast -qp 0 $out &

while ! (jack_lsp | grep $jackClient > /dev/null); do sleep 0.1; done
jack_connect "$PulseAudioJackSink:front-left"  "$jackClient:input_1"
jack_connect "$PulseAudioJackSink:front-right" "$jackClient:input_2"
if [ "$1" != "m" ]; then
  jack_connect "system:capture_1" "$jackClient:input_1"
  jack_connect "system:capture_2" "$jackClient:input_2"
fi
jack_lsp -c
wait $!
