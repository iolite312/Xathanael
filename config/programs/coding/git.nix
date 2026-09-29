{
  programs.git = {
    enable = true;
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDlv/ROyCaJnOxW+tiQ9wntBN3PIXLEExeh/RJzxed3a";
      signByDefault = true;
    };
    settings = {
      gpg = {
        format = "ssh";
      };
      user = {
        name = "iolite312";
        email = "68647023+iolite312@users.noreply.github.com";
      };
    };
  };
}
