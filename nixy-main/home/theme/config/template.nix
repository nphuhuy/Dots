{ lib, ... }:

with lib;

{
  options.theme = {

    waybar-transparent = mkOption {
      type = types.bool;
      description = "Does waybar have a transparent background?";
    };

    wallpaper = mkOption {
      type = types.str;
      description = "Name of the wallpaper (from the wallpapers directory)";
    };

    font = mkOption {
      type = types.str;
      description = "Default font";
    };

    font-mono = mkOption {
      type = types.str;
      description = "Default mono font";
    };

    rounding = mkOption {
      type = types.int;
      description = "Borders rounding";
    };

    gaps-in = mkOption {
      type = types.int;
      description = "Gaps in";
    };

    gaps-out = mkOption {
      type = types.int;
      description = "Gaps out";
    };

    border-size = mkOption {
      type = types.int;
      description = "Border size";
    };

    colors = let
      mkColorOption = name: {
        inherit name;
        value = mkOption {
          type = types.strMatching "[a-fA-F0-9]{6}";
          description = "Color ${name}.";
        };
      };
    in listToAttrs (map mkColorOption [
      "bg"
      "fg"
      "alt-bg"
      "alt-fg"
      "primary-bg"
      "primary-fg"
      "secondary-bg"
      "secondary-fg"
      "color0"
      "color1"
      "color2"
      "color3"
      "color4"
      "color5"
      "color6"
      "color7"
      "color8"
      "color9"
      "color10"
      "color11"
      "color12"
      "color13"
      "color14"
      "color15"
    ]) // {
      primary-ansi-16 = mkOption {
        type = types.str;
        description =
          "Name of the primary color - ansi 16 colors (black, red, green, yellow, blue, magenta, cyan, white, bright-black, bright-red, bright-green, bright-yellow, bright-blue, bright-magenta, bright-cyan, bright-white)";
      };

      primary-ansi-16-number = mkOption {
        type = types.int;
        description = "Set the primary color - ansi 16 colors (0-15)";
      };

    };
  };
}
