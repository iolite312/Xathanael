{
  pkgs,
  impurity,
  ...
}:
let
  programsDir = ./config/programs;
in
{
  imports = [
    (programsDir + "/coding/default.nix")
    (programsDir + "/dms/default.nix")
    (programsDir + "/hyprland/default.nix")
    (programsDir + "/shell/default.nix")
    (programsDir + "/spicetify/default.nix")
    (programsDir + "/ai/default.nix")
  ];

  home.username = "iolite";
  home.homeDirectory = "/home/iolite";

  home.stateVersion = "26.05";

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      AddKeysToAgent = "yes";
    };
    extraConfig = ''
      Host *
        IdentityFile ~/.ssh/id_ed25519
      Host devProxmox
        HostName 192.168.1.80
        User dev
        ForwardAgent yes

      Host Calagopus
        HostName 192.168.1.6
        User calagopus
        ForwardAgent yes

      Host Portainer
        HostName 192.168.1.178
        User dockerhost

      Host Proxmox
        HostName 192.168.1.136
        User root

      Host k3s-c-1
        HostName 192.168.1.200
        User k3s

      Host k3s-c-2
        HostName 192.168.1.201
        User k3s
        
      Host k3s-c-3
        HostName 192.168.1.202
        User k3s
        
      Host k3s-a-1
        HostName 192.168.1.203
        User k3s

      Host k3s-a-2
        HostName 192.168.1.204
        User k3s

      Host k3s-a-3
        HostName 192.168.1.205
        User k3s
        
      Host k3s-lb-1
        HostName 192.168.1.206
        User k3s

      Host k3s-lb-2
        HostName 192.168.1.207
        User k3s
    '';
  };

  home.packages = with pkgs; [
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    nemo-with-extensions
    file-roller
    pwvucontrol
    fastfetch
    filezilla
    obs-studio
    proton-vpn
    protonplus
    heroic
    vesktop
    prismlauncher
    obsidian
    remmina
    goverlay
    mangohud
    kdePackages.kdeconnect-kde
    libreoffice
    oversteer
    solaar
    vlc
    qbittorrent
    xviewer
    hyprshot
    satisfactorymodmanager
    gnome-text-editor
    gnome-calculator
    ncdu
  ];

  # Force the dark color scheme and explicitly set GTK3 theme in dconf
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
    "org/cinnamon/desktop/applications/terminal" = {
      exec = "alacritty";
    };
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
  };

  gtk = {
    enable = true;

    gtk4.theme = null;

    iconTheme = {
      name = "Mint-Y-Yaru";
      package = pkgs.mint-y-icons;
    };

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    font = {
      name = "Adwaita Sans Regular";
      package = pkgs.adwaita-fonts;
      size = 11;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qt6ct";
  };

  xdg.configFile."hypr" = {
    source = impurity.link ./config/programs/hyprland;
    recursive = true;
  };

  xdg.configFile."mimeapps.list".force = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "waterfox.desktop";
      "x-scheme-handler/http" = "waterfox.desktop";
      "x-scheme-handler/https" = "waterfox.desktop";
    };
  };
}
