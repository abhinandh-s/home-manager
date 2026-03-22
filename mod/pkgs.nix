{ pkgs, inputs, ... }: let
dev_pkgs = with pkgs; [
  unstable.tailwindcss_4
  unstable.tailwindcss-language-server
  cargo-watch
  deno
  lua-language-server
  nixd
  ripgrep
  trunk
  tmux
  # wasm-pack
  inputs.wasm-pack.packages.${stdenv.hostPlatform.system}.default
  binaryen # wasm-opt
];

scrpits = with pkgs; [
  age-decrypt
  age-encrypt
  jpg-to-avif
  (backup-encrypted.override { 
   compressionLevel = "9"; 
   })
   compress
   extract
];
in  {
  home.optional.packages = {
    enable = true;
    packages = with pkgs; [
      telegram-desktop
        brave
        librewolf
        libreoffice-fresh
        evince
        kdePackages.gwenview
        zoxide
        typst


    btop
        bat
        bat-extras.batman
        bat-extras.batdiff
        bat-extras.batpipe
        bat-extras.batwatch
        bat-extras.batgrep

            fzf
        zathura
# unstable.krita
# rnote
# gimp-with-plugins
        obs-studio
        # kitty
        inkscape-with-extensions
        flameshot
    ] ++ dev_pkgs ++ scrpits;
  };
}
