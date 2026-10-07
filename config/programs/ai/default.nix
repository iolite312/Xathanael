{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    ollama-rocm
    claude-code
  ];
}
