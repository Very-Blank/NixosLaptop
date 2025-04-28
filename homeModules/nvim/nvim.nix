{...}:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home.file.".config/nvim".source = ./nvim;

  # xdg.configFile."nvim" = {
  #   enable = true;
  #   # source = ./nvim;
  # };
}
