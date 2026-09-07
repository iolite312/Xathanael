{
  pkgs,
  ...
}:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "FiraCode Nerd Font Mono";
          style = "Regular";
        };
        size = 14;
      };

      terminal = {
        shell = "${pkgs.zsh}/bin/zsh";
      };
    };
  };
}
