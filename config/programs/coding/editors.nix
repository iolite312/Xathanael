{
  pkgs,
}:
{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      wakatime.vscode-wakatime
    ];
  };

  home.packages = with pkgs; [
    jetbrains.datagrip
    jetbrains.goland
    jetbrains.idea
    jetbrains.phpstorm
    jetbrains.pycharm
    jetbrains.rider
    jetbrains.rust-rover
    jetbrains.webstorm
    nil
    nixfmt
  ];
}
