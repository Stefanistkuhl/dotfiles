{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # paste your boot config here...
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
    hostName = "Stefiii";
    networkmanager.enable = true;
  };

  # edit as per your location and timezone
  time.timeZone = "Europe/Vienna";
  services.automatic-timezoned.enable = true;
  i18n = {
    defaultLocale = "de_AT.utf8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_AT.utf8";
      LC_IDENTIFICATION = "de_AT.utf8";
      LC_MEASUREMENT = "de_AT.utf8";
      LC_MONETARY = "de_AT.utf8";
      LC_NAME = "de_AT.utf8";
      LC_NUMERIC = "de_AT.utf8";
      LC_PAPER = "de_AT.utf8";
      LC_TELEPHONE = "de_AT.utf8";
      LC_TIME = "de_AT.utf8";
      LC_CTYPE = "en_US.utf8"; # required by dmenu don't change this
    };
  };



  sound.enable = true;

  services = {
    gvfs.enable = true;
    gnome.gnome-keyring.enable = true;
    blueman.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };


  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session.command = ''
  #       ${pkgs.greetd.tuigreet}/bin/tuigreet \
  #       --time \
  #       --asterisks \
  #       --user-menu \
  #       --cmd sway
  #       '';
  #   };
  # };

  environment.etc."greetd/environments".text = ''
    sway
  '';


  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };
  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d";
  };
  users.users.stefiii = {
    isNormalUser = true;
    description = "stefiii";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      xarchiver
    ];
  };
  programs.zsh.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    pkgs.alacritty
    pkgs.home-manager
    dmenu
    git
    nerdfonts
    pkgs.font-awesome
    pamixer
    pkgs.fira-code-symbols
    pkgs.fira-code-nerdfont
    pkgs.jetbrains-mono
    pkgs.material-design-icons
    pkgs.material-icons
    pkgs.material-symbols
    pkgs.material-black-colors
    pkgs.swaynotificationcenter
    networkmanagerapplet
    nitrogen
    pasystray
    picom
    polkit_gnome
    pulseaudioFull
    rofi
    zip
    unrar
    unzip
    neovim
    signal-desktop
    zsh
    fzf
    steam
    flameshot
    pkgs.libreoffice
    pkgs.texliveMedium
    pkgs.zathura
    pkgs.tree-sitter-grammars.tree-sitter-latex
    (python3.withPackages (ps: with ps; [ pandas ]))
    pkgs.nodejs_21
    pkgs.killall
    pkgs.waypaper
    pkgs.swaybg
    pkgs.swayrbar
    pkgs.swaylock
    pkgs.waybar
    pkgs.upower
    pkgs.wofi
    pkgs.xdg-desktop-portal
    pkgs.xdg-desktop-portal-wlr
    pkgs.grim
    pkgs.obsidian
    stow
    pkgs.qview
    fastfetch
    pkgs.libsForQt5.qt5.qtgraphicaleffects
    pkgs.libsForQt5.qt5.qtquickcontrols2
    pkgs.libsForQt5.sddm
    pkgs.starship
    zoxide
  ];
  programs.neovim = {
    enable = true;
    withPython3 = true;
    defaultEditor = true;
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };
  programs.steam.enable = true;
  nix.optimise.automatic = true;
  services.displayManager.sddm.enable = true;
  services.xserver = {
    enable = true;
    xkb.layout = "de";
  };
  nix.settings.auto-optimise-store = true;
  services.flatpak.enable = true;
  #xdg.portal.enable = true;
  programs = {
    thunar.enable = true;
    dconf.enable = true;
  };
  #console.keyMap = "at";
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
  hardware = {
    bluetooth.enable = true;
  };

  # Don't touch this
  system.stateVersion = "23.11";
}
