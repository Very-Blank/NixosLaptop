{ pkgs, ... }: 

{
  programs.firefox = {
    enable = true;
    profiles."blank".extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      bitwarden
      dark-reader
    ];

  };
}
