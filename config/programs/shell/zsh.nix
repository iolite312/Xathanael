{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs.zsh = {
    enable = true;

    histFile = "/home/iolite/.config/zsh";
    histSize = 10000;

    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "colorize"
        "colored-man-pages"
        "zsh-autosuggestions"
      ];
      theme = "robbyrussell";
    };

    shellAliases = {
      sail = "sh $([ -f sail ] && echo sail || echo vendor/bin/sail)";
      artisan = "sail artisan";
    };
  };
}
