{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nixpkgs.config.allowUnfree = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  boot.loader.grub = {
    useOSProber = true;
    efiSupport = true;
    device = "nodev";
  };

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.enableRedistributableFirmware = true;

  # Mematikan daemon bawaan Plasma agar TLP bisa jalan
  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
    };
  };

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };


  networking.hostName = "NixOS";
  networking.networkmanager.enable = true;
 
  hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  };
  
  services.dbus.enable = true;
  services.blueman.enable = true;

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.cloudflare-warp.enable = true;
  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.Kudo = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ]; 
  };

  environment.localBinInPath = true;
  environment.systemPackages = with pkgs; [
    kdePackages.kamoso
    pnpm
    neovim 
    wget
    kitty
    fastfetch
    google-chrome
    zed-editor
    zoom-us
    git
    github-cli
    brave
    tree-sitter
    gcc
    inkscape
    nodejs
    python3
    rclone
    cloudflare-warp
    wl-clipboard
    xclip
    easyeffects
    pavucontrol
  ];

  programs.zsh.enable = true;
  programs.kdeconnect.enable = true;
  programs.mtr.enable = true;
  
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.desktopManager.plasma6.enable = true;
  services.displayManager.plasma-login-manager.enable = true;

  services.openssh.enable = true;

  system.copySystemConfiguration = true;
  system.stateVersion = "26.05"; 
}
