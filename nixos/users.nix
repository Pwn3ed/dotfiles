{ config, pkgs, ... }:

{
  users.users.yourname = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Sudo access
    hashedPassword = "$6$saltsalt$e.g.valid.hash"; # Generate with `mkpasswd -m sha-512`
  };
}

