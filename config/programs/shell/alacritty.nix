{ }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "Fira Code Nerd Font Mono";
          style = "Regular";
        };
        size = 14;
      };

      terminal = {
        shell = "/bin/zsh";
      };
    };
  };
}
