{ pkgs, ... }:
let
  catppuccin = pkgs.catppuccin.mocha;
  # Define conky configuration string
  conkyConfig = /*lua*/ ''
conky.config = {
  --==============================================================================

  --==============================================================================

  -- Size and Position settings --
  alignment = 'top_left',
  gap_x = 50,
  gap_y = 50,
  maximum_width = 1000,
  minimum_height = 400,
  minimum_width = 400,

  -- Text settings --
  use_xft = true,
  override_utf8_locale = true,
  font = 'Roboto:size=1',

  -- Color Settings --
  default_color = 'FFFFFF',
  default_outline_color = 'white',
  default_shade_color = 'white',
  color1 = '${catppuccin.pink}',

  -- Window Settings --
  background = false,
  border_width = 1,
  draw_borders = false,
  draw_graph_borders = true,
  draw_blended = false,
  draw_outline = false,
  draw_shades = false,
  own_window = true,
  own_window_colour = '000000',
  own_window_class = 'Conky',
  own_window_argb_visual = false,
  own_window_type = 'override',
  own_window_transparent = true,
  own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
  stippled_borders = 0,

  -- Others --
  cpu_avg_samples = 2,
  net_avg_samples = 2,
  double_buffer = true,
  out_to_console = false,
  out_to_stderr = false,
  extra_newline = false,
  update_interval = 1,
  uppercase = false,
  use_spacer = 'none',
  show_graph_scale = true,
  show_graph_range = true,
}

conky.text = [[
''${offset 0}''${voffset 18}''${color}''${font Iosevka Nerd Font:bold:size=13}T O''${font}
''${offset 0}''${voffset 3}''${color}''${font Iosevka Nerd Font:bold:size=13}D A Y''${font}
''${offset 0}''${voffset 3}''${color}''${font Iosevka Nerd Font:bold:size=13}I S''${font}
''${offset 0}''${voffset 10}''${color}''${font Iosevka Nerd Font:bold:size=30}''${execi 600 date +"%^A" | sed 's/.\{1\}/&   /g;s/ $//'}''${font}
''${offset 0}''${voffset 0}''${color1}''${font Iosevka Nerd Font:bold:size=30}''${execi 600 date +"%^d" | sed 's/.\{1\}/&   /g;s/ $//'}''${color} ''${execi 600 date +"%^B" | sed 's/.\{1\}/&   /g;s/ $//'}''${font}
''${offset 0}''${voffset 0}''${color}''${font Iosevka Nerd Font:bold:size=30}''${execi 600 date +"%^Y" | sed 's/.\{1\}/&   /g;s/ $//'}''${font}
''${offset 0}''${voffset 10}''${font Iosevka Nerd Font:bold:size=15}''${time %H:%M}''${color1} ''${time %p}''${font}
]]
'';

  conky-bin = /*bash*/ ''
    #!/bin/sh
    conky -c ~/.config/conky/system &
    '';

in
  {
  services.conky = {
    enable = true;
    package = (pkgs.conky.override {
      #     lua = true;
    });
    extraConfig = "-c ~/.config/conky/system";
  };
  home.file.".config/conky/system".text = conkyConfig;
  home.file.".local/bin/conky-autostart.sh".text = conky-bin;
}
