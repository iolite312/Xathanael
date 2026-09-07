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
    "${programsDir}/rofi/default.nix"
    "${programsDir}/shell/default.nix"
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
    addKeysToAgent = "yes";
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
    nemo
    nemo-fileroller
    pwvucontrol
    fastfetch
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
  };

  gtk = {
    enable = true;

    gtk4.theme = null;

    iconTheme = {
      name = "Mint-Y-Yaru";
      package = pkgs.mint-y-icons;
    };

    cursorTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
      size = 24;
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

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  xdg.configFile."hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/iolite/Xathanael/config/programs/hyprland";
    recursive = true;
  };

  xdg.configFile."quickshell" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/iolite/Xathanael/config/programs/quickshell";
    recursive = true;
  };
}
