{ scriptPath ? ./capture_fullscreen_jackpulse.sh
, scriptName ?
    with lib; removeSuffix ".sh" (last (splitString "/" (toString scriptPath)))
, lib
, runCommandLocal
, makeWrapper
, bash, procps, gnused, fzf, xrandr, gnugrep, gawk, ffmpeg, jack2
}:
runCommandLocal scriptName {
  nativeBuildInputs = [ makeWrapper ];
} ''
  makeWrapper ${scriptPath} $out/bin/${scriptName} \
    --prefix PATH : ${lib.makeBinPath [
      bash procps gnused fzf xrandr gnugrep gawk ffmpeg jack2
    ]}
''
