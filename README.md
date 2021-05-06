# capture_fullscreen_jackpulse

To use this script, load Jack modules for PulseAudio like this:

```Shell
pactl load-module module-jack-sink   channels=2 client_name=\"PulseAudio JACK Sink-$UID\"
pactl load-module module-jack-source channels=2 client_name=\"PulseAudio JACK Sink-$UID\"
pacmd set-default-sink jack_out
```
