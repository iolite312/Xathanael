{ }:
{
  programs.zsh = {
    enable = true;

    enableCompletion = true;

    history = {
      path = "/home/iolite/.config/zsh";
      size = 10000;
      save = 10000;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "colorize"
        "colored-man-pages"
      ];
      theme = "robbyrussell";
    };

    autosuggestion.enable = true;

    shellAliases = {
      sail = "sh $([ -f sail ] && echo sail || echo vendor/bin/sail)";
      artisan = "sail artisan";
    };
  };
}
