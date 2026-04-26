{
  config,
  pkgs,
  ...
}:

{
  home.username = "iolite";
  home.homeDirectory = "/home/iolite";

  home.stateVersion = "25.11";

  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos, btw";
    };
  };

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
    source = config.lib.file.mkOutOfStoreSymlink "/home/iolite/nixos-dotfiles/config/qtile";
    recursive = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  home.packages = with pkgs; [
    rofi
    nil
    nixfmt
  ];

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      wakatime.vscode-wakatime
    ];
  };
}
