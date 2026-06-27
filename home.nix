{ config, pkgs, ... }:

{
  home.username = "Kudo";
  home.homeDirectory = "/home/Kudo";
  home.stateVersion = "26.05";

  # Aplikasi user dipindah ke sini
  home.packages = with pkgs; [
    google-chrome brave zed-editor kitty zoom-us inkscape
    easyeffects pavucontrol rclone tree-sitter gcc nodejs python3 vlc kdePackages.kate
  ];

  # Mapping config aplikasi dari folder repo ke ~/.config
  xdg.configFile = {
    "zed".source = ./config-files/zed;
    "easyeffects".source = ./config-files/easyeffects;
    "pavucontrol.ini".source = ./config-files/pavucontrol.ini;
    "nvim".source = ./config-files/nvim;
    "kitty".source = ./config-files/kitty;

    # Config KDE Plasma 6
    "arkrc".source = ./config-files/kde/arkrc;
    "baloofilerc".source = ./config-files/kde/baloofilerc;
    "bluedevilglobalrc".source = ./config-files/kde/bluedevilglobalrc;
    "dolphinrc".source = ./config-files/kde/dolphinrc;
    "gwenviewrc".source = ./config-files/kde/gwenviewrc;
    "kactivitymanagerdrc".source = ./config-files/kde/kactivitymanagerdrc;
    "kcminputrc".source = ./config-files/kde/kcminputrc;
    "kconf_updaterc".source = ./config-files/kde/kconf_updaterc;
    "kded5rc".source = ./config-files/kde/kded5rc;
    "kded6rc".source = ./config-files/kde/kded6rc;
    "kdeglobals".source = ./config-files/kde/kdeglobals;
    "kfontinstuirc".source = ./config-files/kde/kfontinstuirc;
    "kglobalshortcutsrc".source = ./config-files/kde/kglobalshortcutsrc;
    "kiorc".source = ./config-files/kde/kiorc;
    "konsolerc".source = ./config-files/kde/konsolerc;
    "kscreenlockerrc".source = ./config-files/kde/kscreenlockerrc;
    "ksmserverrc".source = ./config-files/kde/ksmserverrc;
    "ksplashrc".source = ./config-files/kde/ksplashrc;
    "ktimezonedrc".source = ./config-files/kde/ktimezonedrc;
    "kwalletrc".source = ./config-files/kde/kwalletrc;
    "kwinoutputconfig.json".source = ./config-files/kde/kwinoutputconfig.json;
    "kwinrc".source = ./config-files/kde/kwinrc;
    "kwinrulesrc".source = ./config-files/kde/kwinrulesrc;
    "plasma-localerc".source = ./config-files/kde/plasma-localerc;
    "plasma-org.kde.plasma.desktop-appletsrc".source = ./config-files/kde/plasma-org.kde.plasma.desktop-appletsrc;
    "plasmanotifyrc".source = ./config-files/kde/plasmanotifyrc;
    "plasmaparc".source = ./config-files/kde/plasmaparc;
    "plasmarc".source = ./config-files/kde/plasmarc;
    "plasmashellrc".source = ./config-files/kde/plasmashellrc;
    "powermanagementprofilesrc".source = ./config-files/kde/powermanagementprofilesrc;
    "spectacle.notifyrc".source = ./config-files/kde/spectacle.notifyrc;
    "spectablerc".source = ./config-files/kde/spectablerc;
  };

  # Zsh & P10k setup
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
    # SUDAH DIGANTI MENJADI initContent AGAR COCOK DENGAN NIXOS REKAYASA BARU
    initContent = ''
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  home.file.".p10k.zsh".source = ./config-files/p10k.zsh;
  programs.home-manager.enable = true;
  services.easyeffects.enable = true;
}
