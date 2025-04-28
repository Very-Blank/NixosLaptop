{inputs, pkgs, ... }:

{
  home = {
    username = "blank";
    homeDirectory = "/home/blank";
    packages = [
      pkgs.firefox
      pkgs.cmake
      pkgs.zig
      pkgs.git
      pkgs.bibata-cursors
      pkgs.maven
      pkgs.jdk23
      pkgs.rustc
      pkgs.cargo
      pkgs.gcc
    ];

    pointerCursor = {
      name = "Bibata-Original-Classic";
      package = pkgs.bibata-cursors;
      size = 16;
      gtk.enable = true;
      x11.enable = true;
    };

    sessionVariables = {
      XCURSOR_THEME = "Bibata-Original-Classic";
      XCURSOR_SIZE = "16";
    };

    stateVersion = "24.11";
  };
  
  programs.home-manager.enable = true;

  imports = [
    ./homeModules/bundle.nix
  ];

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    }; 
  };

  xdg = {
    userDirs.createDirectories = true;
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    theme = {
      name = "Materia-dark";
      package = pkgs.materia-theme;
    };
  };
}
