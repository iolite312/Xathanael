{
  config,
  impurity,
  ...
}:
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."starship.toml" = {
    source = impurity.link ./starship.toml;
  };
}
