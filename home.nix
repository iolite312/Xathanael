{
  config,
  pkgs,
  ...
}:

{
  home.username = "iolite";
  home.homeDirectory = "/home/iolite";

  home.stateVersion = "25.11";

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

  xdg.configFile."qtile" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/iolite/Xathanael/config/qtile";
    recursive = true;
  };

  home.packages = with pkgs; [
    rofi
    nil
    nixfmt
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    alacritty
    nemo
    nemo-fileroller
    pwvucontrol
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
}
