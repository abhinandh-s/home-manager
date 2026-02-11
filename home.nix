{ config, pkgs, userSettings, lib, ... }:

{
  home.username = "abhi";
  home.homeDirectory = "/home/abhi";
  home.stateVersion = "25.11"; 

  imports = [
    ./secrets
    ./lib
    ./mod
    #    ./dev.nix
  ];


  home.packages = with pkgs; [
    xsel # for clipboard
      xclip
      fasd
      just
      feh
      gcc
      lazygit
      pinentry-all
      tree
      picom
      sops
      age
      neovim
    (slstatus.override {
      conf = builtins.readFile ./dots/slstatus/config.h;
    })
   
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "\${xdg.configHome}/emacs/bin"
    ".cargo/bin"
  ];

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    settings.user.name = userSettings.name;
    settings.user.email = userSettings.email.personal;
    signing = {
      # signByDefault = true;
      # key = "55BBE35CA185AD09";
    };
    settings.extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
    settings.aliases = {
      c = "commit -m 'Refactoring'";
      cm = "commit -m";
      ga = "git add";
      gp = "git push";
      gs = "git status";
      gaa = "git add *";
      gcm = "git commit -m";
    };
    ignores = [
      "*~"
      "*.swp"
      "debug/"
      "target/"
      "**/*.rs.bk"
      "*.pdb"
      "*.aux"
      "*.dvi"
      "*.fdb_latexmk"
      "*.fls"
      "*.log"
      "*.synctex"
      "*.lot"
      "*.toc"
      "*.out"
      "*.synctex.gz"
      "#*.org#"
      ".#*"
      "ltximg/"
      "ltximg/*"
    ];
  };

  programs.gpg = {
    enable = true;
    # mutableKeys = true; # allows you to import/export keys manually
    # mutableTrust = true; # allows setting trust interactively
    settings = {
      use-agent = true;
    };
  };

  services.gpg-agent = {
    enable = true;
    #  pinentry = {
    #    package = pkgs.pinentry-curses; # or `pinentry-tty` if you're super minimal
    #  };
    #   defaultCacheTtl = 2592000;
    #   maxCacheTtl = 2592000; # ~ 1 month
    #   enableSshSupport = false; # or true if you want to use GPG for SSH
    extraConfig = ''
      pinentry-program /usr/bin/pinentry-curses
    '';
  };

  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    ".cargo/config.toml".text = ''      [build]
      target-dir = ".cargo/__cache/target"
    '';
    ".local/share/rofi/windows11-list-dark.rasi".source  = ./dots/rofi/windows11-list-dark.rasi;

    ".background-image".source = pkgs.lib.cleanSource ./assets/wallpapers/windows-pink.avif;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
