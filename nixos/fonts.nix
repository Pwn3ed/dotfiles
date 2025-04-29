{ config, pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;

    fontconfig = {
      enable = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel = {
        rgba = "rgb";
      };
    };

    packages = with pkgs; [
      fira-code
      # Add other fonts here if needed
    ];
  };
}
