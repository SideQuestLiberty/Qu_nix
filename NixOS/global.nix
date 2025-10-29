{ user, ... }:
# Global configuration
{
  imports = [
    # boot.nix handles everything until you log in as a user
    ./boot.nix
    # everything else is used only after the boot sequence is done
    ./nvidia.nix
    ./packages.nix
    ./services.nix
    ./customization.nix
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

  # User accounts
  users.users.${user.hostname} = {
    isNormalUser = true;
    description = "${user.name}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
    ];
    packages = [ ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "24.11";
}
