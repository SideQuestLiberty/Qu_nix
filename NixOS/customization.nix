{ lib, config, pkgs, user, inputs, ... }:
# Colors & themes configuration
{
  system.userActivationScripts =
  let
    # Download Catppuccin Qt Theme
    QtTheme = pkgs.fetchurl {
      url = "https://github.com/catppuccin/qt5ct/raw/refs/heads/main/themes/catppuccin-${user.CPflavor}-${user.CPaccent}.conf";
      sha256 = "1i0yplqvzsi6dmrrhw9ib1x7i028x96sc1bj72xcjvss7nmkv5jc";
    };
    # The qt5ct base directory
    Qt5ConfDir = "${user.configPath}/Config/qt5ct";
    # Download Catppuccin Zed theme
    zedTheme = pkgs.fetchurl {
      url = "https://github.com/catppuccin/zed/releases/download/v0.2.22/catppuccin-${user.CPaccent}.json";
      sha256 = "0icml8ymqv0dqwdw5324kw2albkq1k8nkv3p4mn84avzakjydlbp";
    };
    # Download Catppuccin Zed icon theme
    zedIconsSrc = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "zed-icons";
      rev = "v1.20.0";
      sha256 = "sha256-WYIHKd1r0pT99cweBome7L+4Dks6MmSaAmGpGdTGErg=";
    };
    # We need both the icons directory and a .json config file
    zedIcons = "${zedIconsSrc}/icons/";
    zedIconTheme = "${zedIconsSrc}/icon_themes/catppuccin-icons.json";
    # The directory from where Zed will pick up the themes
    zedThemesDir = "${user.configPath}/Config/zed/themes";
    # Download spotify-player theme
    spotifyPlayerTheme = pkgs.fetchurl {
      url = "https://github.com/catppuccin/spotify-player/raw/refs/heads/main/theme.toml";
      sha256 = "1fr27hr09h8779cbgp308hix0ipa57czrmm126s0y93fp07b81n7";
    };
    # Function to link a config directory to the config home
    configHome = "/home/${user.hostname}/.config";
    linkConfDir = name: ''
      rm -rf ${configHome}/${name}
      ln -sfn ${user.configPath}/Config/${name} ${configHome}
    '';
  in {
    # Links the Qt theme in the Qt5 directory
    # Then links the Qt6 files to the Qt5 files to re-use the same config
    QtThemes = ''
      ln -sfn ${QtTheme} ${Qt5ConfDir}/colors/catppuccin.conf
      ln -sfn ${Qt5ConfDir}/qt5ct.conf ${Qt5ConfDir}/qt6ct.conf
      ln -sfn ${Qt5ConfDir} ${configHome}/qt6ct
    '';
    # Links all zed themes where they must go in the Zed themes directory
    zedThemes = ''
      ln -sfn ${zedIconTheme} ${zedThemesDir}/catppuccin-icons.json
      ln -sfn ${zedTheme} ${zedThemesDir}/catppuccin-teal.json
      ln -sfn ${zedIcons} ${zedThemesDir}
    '';
    spotifyPlayerThemes = ''
      ln -sfn ${spotifyPlayerTheme} ${user.configPath}/Config/spotify-player/theme.toml
    '';
    zedConf = linkConfDir "zed";
    Qt5Conf = linkConfDir "qt5ct";
    Qt6Conf = linkConfDir "qt6ct";
    kittyConf = linkConfDir "kitty";
    albertConf = linkConfDir "albert";
    HyprlandConf = linkConfDir "hypr";
    spotifyPlayerConf = linkConfDir "spotify-player";
  };


  environment = {
    systemPackages = with pkgs; [
      libsForQt5.qt5ct                                # Qt5 Configuration Tool
      darkly                                 # Modern application style for Qt
      darkly-qt5                      # Qt5 backwards compatibility for darkly
      papirus-icon-theme                              # Icon theme with extras
      catppuccin-cursors."${user.CPflavor}Light"     # Soothing pastel cursors
      catppuccin-qt5ct                             # Soothing pastel Qt5 theme
      (catppuccin-gtk.override {                   # Soothing pastel GTK theme
        variant = user.CPflavor;
        accents = [ user.CPaccent ];
      })
    ];


    sessionVariables =
    let
      # toSentenceCase transforms "exAMPle STRing" into "Example string"
      # (Here, it transforms "flavor" to "Flavor")
      capitalFlavor = "Catppuccin ${lib.toSentenceCase user.CPflavor} Light";
      cursor-size = 16;
    in {
      # Set both XCURSOR & HYPRCURSOR themes because some apps
      # do not support the latter. Without setting the cursor themes,
      # it "just works", but I like to be aware of why it works.
      XCURSOR_SIZE = cursor-size;
      XCURSOR_THEME = capitalFlavor;
      HYPRCURSOR_SIZE = cursor-size;
      HYPRCURSOR_THEME = capitalFlavor;
      GTK_THEME = "catppuccin-${user.CPflavor}-${user.CPaccent}-standard";
      QT_QPA_PLATFORM = "wayland";
    };


    etc.hypr-wallpaper = {
      # Make the sourced file immutable as part of the /nix/store/
      source = ./../wallpapers/nixos-anime.png;
      # Symlink to it at /etc/wallpapers/hyprland.png
      target = "wallpapers/hyprland.png";
    };
  };


  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = null;
  };
}
