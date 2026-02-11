{ pkgs, ... }: {
 
home.optional.packages = {
    enable = true;
    packages = with pkgs; [];
  };
}
