{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    go_1_26
    kubectl
    lua5
    nodejs_24
    openjdk21
    php85
    php85Packages.composer
    pipx
    python3
    rustup
  ];

  programs.pnpm = {
    enable = true;
    pnpmHome =
      if config.xdg.enable then
        "${config.xdg.dataHome}/pnpm"
      else if pkgs.stdenv.hostPlatform.isDarwin then
        "${config.home.homeDirectory}/Library/pnpm"
      else
        "${config.home.homeDirectory}/.local/share/pnpm";
  };
}
