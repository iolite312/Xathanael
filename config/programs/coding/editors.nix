{
  pkgs,
  ...
}:
{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      wakatime.vscode-wakatime
      aaron-bond.better-comments
      pkief.material-icon-theme
      pkief.material-product-icons
      zhuangtongfa.material-theme
      esbenp.prettier-vscode
      stylelint.vscode-stylelint
      naumovs.color-highlight
      bierner.color-info
      pranaygp.vscode-css-peek
      editorconfig.editorconfig
      usernamehw.errorlens
      dbaeumer.vscode-eslint
      oderwat.indent-rainbow
      mhutchie.git-graph
      eamodio.gitlens
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
