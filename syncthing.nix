/*
  services.syncthing = {
    enable = true;
    overrideDevices = true;     # overrides any devices added or deleted through the WebUI
      overrideFolders = true;     # overrides any folders added or deleted through the WebUI
  };
*/

{ ... }:
{
  services = {
    syncthing = {
      enable = true;
      tray.enable = true;
   #   user = "abhi";
      # dataDir = "/home/abhi/docs";
   #   configDir = "/home/abhi/.config/syncthing";
      overrideDevices = true;     # overrides any devices added or deleted through the WebUI
      overrideFolders = true;     # overrides any folders added or deleted through the WebUI
      settings = {
        gui = {
          user = "abhi";
          password = "1234";
        };
        devices = {
          "abhiRedmi" = { id = "L6XCKGO-E3DYD6U-N7KERVC-KYW7ALB-KSO5L36-OHYAJ7D-RJMEKRT-B46MAQS"; };
        };
        folders = {
          # "docs" = {         # Name of folder in Syncthing, also the folder ID
          #   enable = true;
          #   path = "/home/abhi/docs";    
          #   devices = [ "abhiRedmi" ];
          #   ignorePerms = false;  # By default, Syncthing doesn't sync file permissions. This line enables it for this folder.
          #   versioning = {
          #     type = "trashcan";
          #     params.cleanoutDays = "365";
          #   };
          # };
          "music" = {
            enable = true;
            path = "/home/abhi/music";
            devices = [ "abhiRedmi" ];
            ignorePerms = false;
          };
          # "pictures" = {
          #   enable = true;
          #   path = "/home/abhi/pics/pictures";
          #   devices = [ "abhiRedmi" ];
          #   ignorePerms = false;
          # };
          # "dcim" = {
          #   enable = true;
          #   path = "/home/abhi/pics/dcim";
          #   devices = [ "abhiRedmi" ];
          #   ignorePerms = false;
          # };
          # "sync" = {
          #   enable = true;
          #   path = "/home/abhi/sync";
          #   devices = [ "abhiRedmi" ];
          #   ignorePerms = false;
          # };
        };
      };
    };
  };
}
