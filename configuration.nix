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
  programs.hyprland = {
    enable = true;
  };

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
    };
  };

  users.users.iolite = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    packages = with pkgs; [
      #
    ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    nano
    wget
    inputs.waterfox.packages.${pkgs.system}.waterfox-bin
    seahorse
    # quickshell
    btop-rocm
    qt6.qtwayland
  ];

  # xdg.portal = {
  #   enable = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-gtk
  #     xdg-desktop-portal-hyprland
  #   ];
  #   config.common.default = "*";
  # };

  programs._1password-gui.enable = true;
  programs._1password.enable = true;
  programs.zsh.enable = true;
  programs.steam = {
    enable = true;
  };

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
  services.gvfs.enable = true;

  environment.sessionVariables = {
    SSH_AUTH_SOCK = "/run/user/1000/gcr/ssh";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
  ];

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # nix.settings = {
  #   substituters = [ "https://hyprland.cachix.org" ];
  #   trusted-substituters = [ "https://hyprland.cachix.org" ];
  #   trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  #   # Required so non-root users are allowed to use the above substituter/keys.
  #   # Use @wheel for all sudo users, or list your username explicitly.
  #   trusted-users = [
  #     "root"
  #     "@wheel"
  #   ];
  # };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  system.stateVersion = "26.05";

}
