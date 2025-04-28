{ inputs, config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./systemModules/bundle.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 5d";
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Helsinki";

  services = {
    blueman.enable = true;
    displayManager.ly.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      audio.enable = true;

      alsa = {
        enable = true;
        support32Bit = true; 
      };

      jack.enable = true;
    };

    actkbd = {
      enable = true;
      bindings = [
        { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 5"; }
        { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 5"; }
      ];
    };

    openssh.enable = true;
  };

  programs = {
    light.enable = true;
    zsh.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    tuxedo-rs = {
      enable = true;
      tailor-gui.enable = true;
    };

    tuxedo-drivers.enable = true;
  };

  # boot.kernelParams = [
  #   "tuxedo_keyboard.mode=0"
  #   "tuxedo_keyboard.brightness=25"
  #   "tuxedo_keyboard.color_left=0x0000ff"
  # ];

  users.users.blank = {
    isNormalUser = true;
    extraGroups = [ "wheel" "input" "bluetooth" "networkmanager" "video" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    electron
    home-manager
    vim
    wget
    unzip
    seatd
  ];

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      noto-fonts
      noto-fonts-emoji
      twemoji-color-font
      font-awesome
      powerline-fonts
      powerline-symbols
      (nerdfonts.override { fonts = [ "0xProto" ]; })
    ];
  };


  system.stateVersion = "24.11";
}

