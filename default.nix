{ script1Path ? ./capture_fullscreen_jackpulse.sh
, script1Name ?
    with lib; removeSuffix ".sh" (last (splitString "/" (toString script1Path)))
, script2Path ? ./checkMic.sh
, script2Name ?
    with lib; removeSuffix ".sh" (last (splitString "/" (toString script2Path)))
, lib
, runCommandLocal
, makeWrapper
, bash, procps, gnused, fzf, xrandr, gnugrep, gawk, ffmpeg, jack2
, jack_capture
}:
runCommandLocal script1Name {
  nativeBuildInputs = [ makeWrapper ];
} ''
  makeWrapper ${script1Path} $out/bin/${script1Name} \
    --prefix PATH : ${lib.makeBinPath [
      bash procps gnused fzf xrandr gnugrep gawk ffmpeg jack2
    ]}
  makeWrapper ${script2Path} $out/bin/${script2Name} \
    --prefix PATH : ${lib.makeBinPath [
      bash jack_capture
    ]}
''
