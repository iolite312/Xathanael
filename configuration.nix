{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.dank-greeter.nixosModules.default
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  programs.hyprland = {
    enable = true;
  };

  programs.dms-greeter = {
    enable = true;
    compositor = {
      name = "hyprland";
      customConfig = ''
        hl.config({
          input = {
              numlock_by_default = true,
          },
        })
      '';
    };

    configHome = "/home/iolite";

    configFiles = [
      "/home/iolite/.config/DankMaterialShell/settings.json"
    ];

    logs = {
      save = true;
      path = "/tmp/dms-greeter.log";
    };
  };

  systemd.user.targets.hyprland-session = {
    description = "Hyprland session";
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
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
      "docker"
    ];
    packages = with pkgs; [
      #
    ];
    shell = pkgs.zsh;
    initialPassword = "1234";
  };

  environment.systemPackages = with pkgs; [
    nano
    wget
    inputs.waterfox.packages.${stdenv.hostPlatform.system}.waterfox-bin
    seahorse
    btop
    qt6.qtwayland
    adwaita-icon-theme
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.hyprland.preferred = [
      "hyprland"
      "gtk"
    ];
  };

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
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
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

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  system.stateVersion = "26.05";

}
