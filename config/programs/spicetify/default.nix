{
  inputs,
  pkgs,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      fullScreen
    ];
    theme = spicePkgs.themes.sleek;
    colorScheme = "UltraBlack";
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
    ];
  };
}
