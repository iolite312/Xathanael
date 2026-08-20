{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.hyprland.enable = true;

  services.xrdp.enable = true;
  # services.xrdp.defaultWindowManager = "startplasma-x11";
  services.xrdp.openFirewall = true;
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
    };
  };

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  users.users.iolite = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    packages = with pkgs; [
      #
    ];
  };

  environment.systemPackages = with pkgs; [
    nano
    wget
    inputs.waterfox.packages.${pkgs.system}.waterfox-bin
    seahorse
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  programs._1password-gui.enable = true;
  programs._1password.enable = true;

  programs.dconf = {
    enable = true;
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        waterfox
        waterfox-bin
      '';
      mode = "0755";
    };
  };

  services.gnome.gnome-keyring.enable = true;

  environment.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/gcr/ssh";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  system.stateVersion = "25.11";

}
