# capture_fullscreen_jackpulse

`capture_fullscreen_jackpulse.sh` runs ffmpeg to capture full screen video of selected DISPLAY and Pulse Audio outputs via Jack.  

`checkMic.sh` is a one-liner helper script for testing Jack system input.

### Note

To use `capture_fullscreen_jackpulse.sh`, load Jack modules for PulseAudio like this:

```Shell
pactl load-module module-jack-sink   channels=2 client_name=\"PulseAudio JACK Sink-$UID\"
pactl load-module module-jack-source channels=2 client_name=\"PulseAudio JACK Sink-$UID\"
pacmd set-default-sink jack_out
```

Or, edit `PulseAudioJackSink` environment variable in the script.
