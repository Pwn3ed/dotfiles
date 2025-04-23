{ config, pkgs, ... }:

{
  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "pt_BR.UTF-8";
  console.keyMap = "us";

  nixpkgs.config.allowUnfree = true;
}
