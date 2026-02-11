{ pkgs, ... }: let
dev_pkgs = with pkgs; [
  unstable.tailwindcss_4
  cargo-watch
  deno
  lua-language-server
  nixd
  trunk
  tmux
  wasm-pack
];

scrpits = with pkgs; [
  age-decrypt
  age-encrypt
  jpg-to-avif
  (backup-encrypted.override { 
   compressionLevel = "9"; 
   })
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
        zoxide
        typst

        fzf
        zathura
# unstable.krita
# rnote
# gimp-with-plugins
# obs-studio
        inkscape-with-extensions
        flameshot
    ] ++ dev_pkgs ++ scrpits;
  };
}
