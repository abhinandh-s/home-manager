{
  config,
  lib,
  pkgs,
  ...
}: {
  options.home.optional.packages = {
    enable = lib.mkEnableOption "perform full setup";
    packages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = with pkgs; [
        (writeShellScriptBin "ff"
          /*
          bash
          */
          ''
            ${fzf}/bin/fzf -e --cycle --walker-skip=.git,.direnv | xargs -r nvim
          '')
      ];
    };
  };

  config = lib.mkIf config.home.optional.packages.enable {
    home.packages = config.home.optional.packages.packages;
  };
}
