{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  home.packages = with pkgs; [
    alsa-utils
    qt6.qtmultimedia
    qt6.qt5compat
    qt6.qtwebsockets
    qt6.qtwebengine
    gtk3
    cava
    bluez
    networkmanager
    lm_sensors
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
