{
  inputs,
  config,
  ...
}:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = false;

    enableSystemMonitoring = true;
    enableVPN = false;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
  };

  xdg.configFile."DankMaterialShell/settings.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/iolite/Xathanael/config/programs/dms/settings.json";
  };
}
