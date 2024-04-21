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
      allowedTCPPorts = [];
      allowedUDPPorts = [];
    };
    hostName = "Stefiii";
    networkmanager.enable = true;
  };

  # edit as per your location and timezone
  time.timeZone = "Europe/Vienna";
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
      LC_CTYPE="en_US.utf8"; # required by dmenu don't change this
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

  
    services.greetd = {
      enable = true;
      settings = {
        default_session.command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd sway
          '';
      };
    };

    environment.etc."greetd/environments".text = ''
      sway
      '';
   

  nixpkgs = {
    config = {
      allowUnfree = true;
      pulseaudio = true;
    };
  };

  # Edit the username below (replace 'neeraj')
  users.users.stefiii = {
    isNormalUser = true;
    description = "stefiii";
    extraGroups = [ "networkmanager" "wheel"];
    packages = with pkgs; [
      xarchiver
    ];
  };
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    alacritty
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
    dunst
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

  programs.steam.enable = true;
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  programs = {
    thunar.enable = true;
    dconf.enable = true;
  };
  #console.keyMap = "at";
  security = {
    polkit.enable = true;
    rtkit.enable = true;
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
  system.stateVersion = "23.05";
}
