{ pkgs, config, ... }:

let
  homedir = config.home.homeDirectory;

  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    if [[ $2 == "swappy" ]];then
      folder="/tmp"
    else
      folder="$HOME/Pictures/screenshots"
    fi
    filename="$(date +%Y-%m-%d_%H:%M:%S).png"
    mode="region" # Default to region

    if [[ $1 == "window" ]];then
      mode="window"
    elif [[ $1 == "monitor" ]];then
      mode="output"
    fi

    ${pkgs.hyprshot}/bin/hyprshot -m $mode -o $folder -f $filename -s || exit 1

    if [[ $2 == "swappy" ]];then
      ${pkgs.swappy}/bin/swappy -f "$folder/$filename" -o "$HOME/Pictures/screenshots/$filename"
      exit 0
    fi

    message="  Screenshot saved"

    ${pkgs.libnotify}/bin/notify-send "$message" \
                --icon="$folder/$filename" \
                --replace-id="$(cat "/tmp/nixy-notification" 2>/dev/null || echo 0)" --print-id > "/tmp/nixy-notification"
  '';
in { home.packages = with pkgs; [ hyprshot screenshot ]; }
