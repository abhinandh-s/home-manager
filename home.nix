{ config, pkgs, userSettings, lib, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "abhi";
  home.homeDirectory = "/home/abhi";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  imports = [
    ./secrets
    # ./lib
    #  ./mod
    #    ./dev.nix
  ];


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    xsel # for clipboard
    xclip
    feh
    telegram-desktop
    brave
    librewolf
    unstable.tailwindcss_4
    cargo-watch
    libreoffice-fresh
    gcc
    neovim
    tmux
    evince
    just
    trunk
    fasd
    picom
    sops
    age
    zoxide
    typst
    lua-language-server
    nixd
    deno
    pinentry-all
    fzf
    zathura
    lazygit
    tree
    wasm-pack
    # unstable.krita
    # rnote
    # gimp-with-plugins
    # obs-studio
    # inkscape-with-extensions
    flameshot
    (slstatus.override {
      conf = builtins.readFile ./dots/slstatus/config.h;
    })
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
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
