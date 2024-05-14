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

  # environment.etc."greetd/environments".text = ''
  #   sway
  # '';


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
  #programs.zsh.enable = true;
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
    polkit_gnome
    pulseaudioFull
    rofi
    zip
    unrar
    tlp
    unzip
    neovim
    signal-desktop
    zsh
    fzf
    steam
    pkgs.texliveFull
    pkgs.zathura
    pkgs.tree-sitter-grammars.tree-sitter-latex
    (python3.withPackages (ps: with ps; [ pandas matplotlib seaborn numpy ]))
    pkgs.nodejs
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
    libreoffice
    pkgs.libsForQt5.qt5.qtgraphicaleffects
    pkgs.libsForQt5.qt5.qtquickcontrols2
    pkgs.libsForQt5.sddm
    pkgs.starship
    zoxide
    pkgs.wl-clipboard
    pkgs.slurp
    pkgs.imagemagick
    pkgs.swappy
    pkgs.uwufetch
    pkgs.cliphist
    zoxide
    pkgs.hyfetch
    nsnake
    bastet
  ];
  programs.hyprland.enable = true;
  programs.neovim = {
    enable = true;
    withPython3 = true;
    defaultEditor = true;
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  programs = {
    zsh = {
      enable = true;
      interactiveShellInit = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
      '';
    };
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
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #Optional helps save long term battery health
      # START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      # STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

    };
  };
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
