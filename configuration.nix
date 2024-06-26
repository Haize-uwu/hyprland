# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "za";
    xkbVariant = "";
  };
  # swaylock config
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
  # Enable bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # enable writing tablet
  hardware.opentabletdriver.enable = true;
  # start daemon 
  hardware.opentabletdriver.daemon.enable = true;
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Enable hypr plugin manager
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.haize = {
    isNormalUser = true;
    description = "haize";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      nitch
      alacritty
      kitty
      hyprland
      
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowInsecure = true;

  programs.hyprland.enable = true;  
  # Steam install
  programs.steam = {
     enable = true;
     remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
     dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  
   # Bluetooth


    nixpkgs.config.permittedInsecurePackages = [
        "electron-25.9.0"
    ];
            
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   wget
   neovim
   waybar
   dunst 
   libnotify
   git
   blueman
   cargo
   cmake
   emacs
   fzf
   gcc
   glibc
   gcolor2
   gnumake
   gparted
   gnuplot
   grimblast
   texlive.combined.scheme-medium
   
   hyprpicker
   meson
   mpv
   networkmanagerapplet
   obs-studio
   pandoc
   pfetch
   python311
   ranger
   sddm
   rofi
   redshift
   obsidian
   btop
   cava
   clipboard-jh
   cliphist
   cmake
   feh
   fish
   lua
   lutris
   mpd
   pavucontrol
   ripgrep
   wlogout
   swaylock
   rnote
   git-credential-manager
   git-credential-oauth
   xsel
   yazi
   zathura
  ];
  # fonts
   fonts.fontDir.enable = true;
   fonts.fonts = with pkgs; [
   nerdfonts
   font-awesome
   google-fonts
   iosevka
   ];
  # locate
   services.locate = {
   enable = true;
   locate = pkgs.mlocate;
   };

  # xdg portals
   xdg.portal.enable = true;

 # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
