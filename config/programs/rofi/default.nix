{
  config,
  ...
}:
{
  programs.rofi = {
    enable = true;
    configPath = "$XDG_CONFIG_HOME/rofi/config.rasi";
  };

  xdg.configFile."rofi" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/iolite/Xathanael/config/programs/rofi";
    recursive = true;
  };
}
