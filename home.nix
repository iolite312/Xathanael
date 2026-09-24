{
  config,
  pkgs,
  ...
}:
let
  programsDir = ./config/programs;
in
{
  imports = [
    "${programsDir}/hyprland/default.nix"
    "${programsDir}/shell/default.nix"
    "${programsDir}/spicetify/default.nix"
    "${programsDir}/dms/default.nix"
  ];

  home.username = "iolite";
  home.homeDirectory = "/home/iolite";

  home.stateVersion = "26.05";

  programs.git = {
    enable = true;
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDlv/ROyCaJnOxW+tiQ9wntBN3PIXLEExeh/RJzxed3a";
      signByDefault = true;
    };
    settings = {
      gpg = {
        format = "ssh";
      };
      user = {
        name = "iolite312";
        email = "68647023+iolite312@users.noreply.github.com";
      };
    };
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      AddKeysToAgent = "yes";
    };
    extraConfig = ''
      Host *
        IdentityFile ~/.ssh/id_ed25519
    '';
  };

  home.packages = with pkgs; [
    nil
    nixfmt
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    nemo-with-extensions
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
  ];

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      wakatime.vscode-wakatime
    ];
  };

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
    source = config.lib.file.mkOutOfStoreSymlink "/home/iolite/Xathanael/config/programs/hyprland";
    recursive = true;
  };
}
