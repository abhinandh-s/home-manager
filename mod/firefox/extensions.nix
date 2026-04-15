{lib, ...}: {
  ExtensionSettings = with builtins; let
    extension = shortId: uuid: defaultArea: {
      name = uuid;
      value = {
        install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
        installation_mode = "force_installed"; # normal_installed
        default_area = defaultArea;
        blocked_install_message = "Fucking forget it";
      };
    };
  in
    listToAttrs [
      (extension "*" "" "menupanel")
      (extension "sponsorblock" "sponsorBlocker@ajay.app" "menupanel")
      (extension "darkreader" "addon@darkreader.org" "menupanel")
      (extension "rsshub-radar" "i@diygod.me" "navbar")
      (extension "awesome-rss" "{97d566da-42c5-4ef4-a03b-5a2e5f7cbcb2}" "menupanel")
      (extension "ublock-origin" "uBlock0@raymondhill.net" "navbar")
      (extension "catppuccin-mocha-red" "{e4c06efe-4936-4ca0-87e2-4a47dc5fa5ee}" "menupanel")
      (extension "proton-pass" "78272b6fa58f4a1abaac99321d503a20@proton.me" "navbar")
      # (extension "catppuccin-mocha-teal" "{3f8844e2-3fc1-4104-9773-0f4bb98eab69}" "menupanel")
    ];
  "3rdparty".Extensions = {
    "uBlock0@raymondhill.net".adminSettings = {
      userSettings = rec {
        uiTheme = "dark";
        uiAccentCustom = true;
        uiAccentCustom0 = "#f38ba8";
        cloudStorageEnabled = lib.mkForce false; # Security liability?
        importedLists = [
          "https://raw.githubusercontent.com/abhinandh-s/nixdots/refs/heads/master/dots/uBlockOrigin/filter.txt"
          "https://filters.adtidy.org/extension/ublock/filters/3.txt"
          "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
        ];
        externalLists = lib.concatStringsSep "\n" importedLists;
      };
      selectedFilterLists = [
        "CZE-0"
        "adguard-generic"
        "adguard-annoyance"
        "adguard-social"
        "adguard-spyware-url"
        "easylist"
        "easyprivacy"
        "https://raw.githubusercontent.com/abhinandh-s/nixdots/refs/heads/master/dots/uBlockOrigin/filter.txt"
        "https://github.com/DandelionSprout/adfilt/raw/master/LegitimateURLShortener.txt"
        "plowe-0"
        "ublock-abuse"
        "ublock-badware"
        "ublock-filters"
        "ublock-privacy"
        "ublock-quick-fixes"
        "ublock-unbreak"
        "urlhaus-1"
      ];
    };
  };
}
