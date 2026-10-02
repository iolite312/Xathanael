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

  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos-maniac"; # Define your hostname.

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
  };
  users.mutableUsers = true;

  environment.systemPackages = with pkgs; [
    nano
    wget
    inputs.waterfox.packages.${stdenv.hostPlatform.system}.waterfox-bin
    seahorse
    btop
    qt6.qtwayland
    adwaita-icon-theme
    cifs-utils
    efibootmgr
    google-fonts
    cups-pk-helper
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

  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
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
  services.udisks2.enable = true;

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

  services.power-profiles-daemon.enable = true;

  services.accounts-daemon.enable = true;

  services.printing.enable = true;
  services.printing.drivers = [
    pkgs.canon-cups-ufr2
    pkgs.cnijfilter2
  ];
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  fileSystems."/mnt/nas" = {
    device = "//192.168.1.160/nas";
    fsType = "cifs";
    options =
      let
        # this line prevents hanging on network split
        automount_opts = "x-systemd.automount,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

      in
      [
        "${automount_opts},credentials=/home/iolite/smb-secrets"
        "nofail"
        "x-gvfs-show"
        "uid=1000,gid=100"
      ];
  };

  fileSystems."/mnt/Big_D" = {
    device = "/dev/disk/by-uuid/be9ee9ea-b231-47f2-a4c6-a32662cd2f3f";
    fsType = "ext4";
    options = [
      "defaults"
      "x-gvfs-show"
    ];
  };

  fileSystems."/mnt/Small_D" = {
    device = "/dev/disk/by-uuid/ae837c36-87e3-4c6d-b410-abff9e005ed3";
    fsType = "ext4";
    options = [
      "defaults"
      "x-gvfs-show"
    ];
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
