{
  config,
  pkgs,
  lib,
  ...
}:

{
  # imports = [
  #   ./hypridle.nix
  # ];

  # wayland.windowManager.hyprland = {
  #   enable = true;
  # };

  home.packages = with pkgs; [
    rofi
    pavucontrol
    fortune
    wl-screenrec
    alsa-utils
    swww
    networkmanager_dmenu
    wl-clipboard
    fd
    qt6.qtmultimedia
    qt6.qt5compat
    qt6.qtwebsockets
    qt6.qtwebengine
    ripgrep
    gtk3
    cava
    cliphist
    tree
    jq
    socat
    pamixer
    brightnessctl
    acpi
    iw
    bluez
    libnotify
    networkmanager
    lm_sensors
    bc
    pulseaudio
    ladspaPlugins
    ladspa-sdk
    imagemagick
  ];

  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
