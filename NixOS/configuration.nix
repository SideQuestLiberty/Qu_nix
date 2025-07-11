{ config, lib, pkgs, user, inputs,  ... }:

{
  imports = [
    ./boot.nix
    ./nvidia.nix
    ./packages.nix
    ./services.nix
    ./networking.nix
    ./hardware-configuration.nix
  ];


  console.keyMap = "fr";
  services.xserver.xkb.layout = "fr";


  # Select internationalisation properties.
  time.timeZone = "Europe/Paris";
  # English default language
  i18n.defaultLocale = "en_US.UTF-8";
  # French default formatting
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  environment = {
    variables =
    let
      # toSentenceCase transforms "exAMPle STRing" into "Example string"
      # (Here, it transforms "flavor" to "Flavor")
      capitalFlavor = "Catppuccin ${lib.toSentenceCase user.CP-flavor} Light";
      cursor-size = 16;
    in {
      # Set the system configuration directory
      #XDG_CONFIG_HOME = ./../Config/
      # Set both XCURSOR & HYPRCURSOR themes because some apps
      # do not support the latter. Without setting the cursor themes,
      # it "just works", but I like to be aware of why it works.
      XCURSOR_SIZE = cursor-size;
      XCURSOR_THEME = capitalFlavor;
      HYPRCURSOR_SIZE = cursor-size;
      HYPRCURSOR_THEME = capitalFlavor;
      GTK_THEME = "catppuccin-${user.CP-flavor}-${user.CP-accent}-standard";
      # You guessed it - proprietary software that does not "just work"
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      # Hint Electron apps to use Wayland
      NIXOS_OZONE_WL = "1";
      # Set default editor
      EDITOR = "zeditor";
    };
    etc.hypr-wallpaper = {
      # Make the sourced file immutable as part of the /nix/store/
      source = ./../wallpapers/nixos-anime-mocha.png;
      # Symlink to it at /etc/wallpapers/hyprland.png
      target = "wallpapers/hyprland.png";
    };
  };


  # User accounts
  users.users.${user.hostname} = {
    isNormalUser = true;
    description = "${user.name}";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    packages = with pkgs; [];
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.11";
}
