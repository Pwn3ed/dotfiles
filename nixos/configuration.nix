{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./options.nix
    ./packages.nix
    ./managers.nix
    ./users.nix
    ./env.nix
    ./network.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh.enable = true;

  system.stateVersion = "24.05"; # Adjust to match your NixOS version
}
