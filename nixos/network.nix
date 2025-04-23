{ config, pkgs, ... }:

{
  networking = {
    hostName = "nixos"; # Set your hostname
    networkmanager.enable = true;
    firewall.enable = true;

    # Optional: Static IP example
    # interfaces.enp3s0.ipv4.addresses = [{
    #   address = "192.168.1.100";
    #   prefixLength = 24;
    # }];
    # defaultGateway = "192.168.1.1";
    # nameservers = [ "8.8.8.8" "1.1.1.1" ];
  };
}

