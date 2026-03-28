{
  den.aspects.starship = {
    homeManager = {
      programs.starship = {
        enable = true;
        settings = {
          "$schema" = "https://starship.rs/config-schema.json";

          format = "[](color_frost_blue)$os$username[](bg:color_snow_storm_light fg:color_frost_blue)$directory[](fg:color_snow_storm_light bg:color_frost_green_aqua)$git_branch$git_status[](fg:color_frost_green_aqua bg:color_polar_night_darker)$docker_context$conda$pixi$aws$gcloud[](fg:color_polar_night_darker bg:color_polar_night_darkest)";

          right_format = "[](fg:color_frost_green_aqua)$c$python$elixir$elm$golang$haskell$java$julia$nodejs$nim$rust$scala[](fg:color_snow_storm_light bg:color_frost_green_aqua)$cmd_duration[](fg:color_frost_blue bg:color_snow_storm_light)$character[](fg:color_frost_blue)";

          palette = "nord";

          palettes.nord = {
            color_polar_night_darkest = "#2e3440";
            color_polar_night_darker = "#3b4252";
            color_polar_night_medium = "#434c5e";
            color_polar_night_light = "#4c566a";
            color_snow_storm_light = "#d8dee9";
            color_snow_storm_medium = "#e5e9f0";
            color_storm_snow_dark = "#eceff4";
            color_frost_green_aqua = "#8fbcbb";
            color_frost_light_blue = "#88c0d0";
            color_frost_blue = "#81a1c1";
            color_frost_dark_blue = "#5e81ac";
            color_aurora_red = "#bf616a";
            color_aurora_orange = "#d08770";
            color_aurora_yellow = "#ebcb8b";
            color_aurora_green = "#a3be8c";
            color_aurora_purple = "#b48ead";
          };

          os = {
            disabled = false;
            style = "bg:color_frost_blue fg:color_snow_storm_light";
            symbols.NixOS = " ";
          };

          username = {
            show_always = false;
            style_user = "bg:color_frost_blue fg:color_snow_storm_light";
            style_root = "bg:color_aurora_red fg:color_snow_storm_light";
            format = "[ $user ]($style)";
          };

          directory = {
            style = "fg:color_polar_night_darkest bg:color_snow_storm_light";
            format = "[ $path ]($style)";
            truncation_length = 3;
            truncation_symbol = "…/";
            substitutions = {
              "Documents" = "󰈙 ";
              "Downloads" = " ";
              "Music" = "󰝚 ";
              "Pictures" = " ";
              "Developer" = "󰲋 ";
            };
          };

          git_branch = {
            symbol = "";
            style = "bg:color_frost_green_aqua";
            format = "[[ $symbol $branch ](fg:color_polar_night_darkest bg:color_frost_green_aqua)]($style)";
          };

          git_status = {
            style = "bg:color_frost_green_aqua";
            format = "[[($all_status$ahead_behind )](fg:color_polar_night_darkest bg:color_frost_green_aqua)]($style)";
            untracked = "?\${count} ";
            stashed = "$\${count} ";
            modified = "!\${count} ";
            staged = "+\${count} ";
            renamed = "»\${count} ";
            deleted = "✘\${count} ";
            conflicted = "=\${count} ";
            ahead = "⇡\${count} ";
            behind = "⇣\${count} ";
            diverged = "⇕⇡\${ahead_count} ⇣\${behind_count} ";
          };

          # Programming Language Modules
          nodejs = {
            symbol = " ";
            style = "bg:color_frost_green_aqua fg:color_polar_night_darkest";
            format = "[$symbol($version)]($style)";
          };

          rust = {
            symbol = "󱘗 ";
            style = "bg:color_frost_green_aqua fg:color_polar_night_darkest";
            format = "[$symbol($version) ]($style)";
          };

          python = {
            symbol = " ";
            style = "bg:color_frost_green_aqua fg:color_polar_night_darkest";
            format = "[$symbol($version) ]($style)";
            detect_files = [];
            detect_extensions = [];
          };

          docker_context = {
            symbol = " ";
            style = "bg:color_polar_night_darker fg:color_snow_storm_light";
            format = "[$symbol( $context) ]($style)";
          };

          cmd_duration = {
            min_time = 500;
            format = "[$duration ](bg:color_snow_storm_light fg:color_polar_night_darkest)";
          };

          character = {
            format = "$symbol";
            success_symbol = "[✔](bold color_polar_night_darkest bg:color_frost_blue)";
            error_symbol = "[✖](bold color_polar_night_darkest bg:color_frost_blue)";
          };
        };
      };
    };
  };
}
