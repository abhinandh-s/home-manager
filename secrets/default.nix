/*
https://samleathers.com/posts/2022-02-11-my-new-network-and-sops.html
*/
{config, ...}: let
  mode = "0600"; # owner = rw- | group = --- | others = ---
in {
  sops = {
    age.keyFile = config.home.homeDirectory + "/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets = {
      abhi-cargo-token = { };
      cargo-token = {
        path = config.home.homeDirectory + "/.cargo/credentials.toml";
        inherit mode;
      };
      y-key = {
        path = config.home.homeDirectory + "/.local/share/age/key.txt";
        inherit mode;
      };
      age-public-key = {
        path = config.home.homeDirectory + "/.local/share/age/pub_key.txt";
        inherit mode;
      };
      github_ssh_key = {
        path = config.home.homeDirectory + "/.ssh/id_ed25519";
        inherit mode;
      };
      mobile_ssh_key = {
        path = config.home.homeDirectory + "/.ssh/id_rsa";
        inherit mode;
      };
      "kde_connect/trusted_device_keys" = {
        path = config.home.homeDirectory + "/.config/kdeconnect/trusted_devices";
        inherit mode;
      };
      "kde_connect/certificate_pem" = {
        path = config.home.homeDirectory + "/.config/kdeconnect/certificate.pem";
        inherit mode;
      };
      "kde_connect/privateKey_pem" = {
        path = config.home.homeDirectory + "/.config/kdeconnect/privateKey.pem";
        inherit mode;
      };
    };
  };
}
