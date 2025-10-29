{
  pkgs,
  user,
  inputs,
  ...
}:
# Packages configuration
{
  # Configuration of the Package Manager (nix)
  nix = {
    channel.enable = false;
    optimise.automatic = true;
    optimise.dates = [ "weekly" ];
    gc.automatic = true;
    gc.dates = "weekly";
    # Enable Flakes
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.sessionVariables = {
    # Hint Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";
    # Set default editor
    EDITOR = "zeditor";
  };

  # Configure packages installed in system profile
  programs = {
    bash = {
      undistractMe.enable = true;
      undistractMe.timeout = 60;
      completion.enable = true;
      shellAliases = {
        config = "zeditor ${user.configPath}; exit";
        rebuild = "sudo nixos-rebuild --upgrade-all --flake ${user.configPath}#Qu_nix";
      };
    };
    hyprland = {
      enable = true; # Smooth Wayland tiling compositor
      xwayland.enable = true;
      #withUWSM = true;
    };
    steam = {
      enable = true; # Game store / library / launcher
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    }; # TODO: Add gamescope and MAKiT work
    gamemode = {
      enable = true; # System optimizer for Games
      enableRenice = true;
    };
    obs-studio = {
      enable = true; # Screen recording utility
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi # Enable GPU Hardware encoder through NVidia
        input-overlay # Overlays input on top of recording
        obs-backgroundremoval # Replace background in portait video & image
      ];
    };
    hyprlock.enable = true; # Screen locking utility
    file-roller.enable = true; # File archiver and unzipper
    git.enable = true; # Version control utility
  };

  environment.systemPackages =
    with pkgs;
    let
      fromInputs = name: inputs."${name}".packages."${user.system}".default;
    in
    [
      ### NEEDED AS DEPENDENCIES
      egl-wayland # NVidia EGL support library for Wayland
      nvidia-vaapi-driver # Video-Audio hardware acceleration API
      hyprpolkitagent # Polkit agent: allows apps to elevate privileges
      ffmpeg-full # Anything you would need to handle videos
      libsecret # Secret handling library
      wl-clipboard # Needed for swappy, clipboard utility

      ### BASIC SOFTWARE
      kitty # Customizable terminal emulator
      tofi # Fast application launcher
      albert # Customizable launcher
      nemo-with-extensions # Nautilus fork with more features
      zed-editor-fhs # Fast, Reliable, Feature-Rich (frfr) text editor
      anytype # Featureful notes-taking app
      libreoffice-qt6-fresh # Office documents editors
      gimp3-with-plugins # Image viewer & editor
      vlc # Everybody knows what VLC is
      protonmail-bridge # Bridge to use ProtonMail with other clients
      proton-pass # Private, free Password Manager
      protonvpn-gui # Private, free VPN
      beeper # Universal chat app
      vesktop # Vencord faster, lighter, privater, screensharer discord client
      netflix # Netflix through Google chrome
      spotify-player # Terminal music player & Daemon
      cemu # Highly configurable Wii-U emulator
      ukmm # Zelda: BotW mod manager
      prismlauncher # Minecraft instances manager
      davinci-resolve # Editing software
      blender # 3D creation/animation software
      godot # 2D/3D Game engine
      lmms # Digital Audio Workstation
      wine-wayland # Win32 API Linux implementation for Wayland
      lxqt.qps # Process viewer & manager
      mangohud # FPS, Heat & CPU/GPU load Overlay
      fastfetch # Fetch and display system information
      (inputs.zen-browser.packages."${user.system}".beta-unwrapped.override {
        applicationName = "Zen Browser"; # Gecko Sidebar Browser
        policies = import ./../Firefox/policies.nix;
      })

      ### UTILITIES
      (fromInputs "quickshell") # DIY Qt widget system
      wev # Wayland Event Viewer
      input-remapper # Remap input-specific keys
      dunst # Lightwheight customizable notification Daemon
      slurp # Screenshot region selecting utility
      grim # Screenshot capture utility
      swappy # Screenshot editing utility
      # TODO: get a clipboard manager
      brightnessctl # Screen backlight control Daemon
      hyprsunset # Blue light filter (& gamma filter)
      hyprpaper # IPC-controlled wallpaper utility
      hyprpicker # Color picking utility
      hyprland-qt-support # QML style for hypr* qt6 apps
      nil # Language server for Nix
      nixd # Language server for Nix
      hyprls # Language server for Hyprlang
    ];

  fonts = {
    packages = with pkgs; [
      fira
      fira-math
      fira-code
      fira-code-symbols
      font-awesome
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      noto-fonts-monochrome-emoji
      nerd-fonts.hack
      nerd-fonts.tinos
      nerd-fonts.go-mono
      nerd-fonts._0xproto
      nerd-fonts.monaspace
      nerd-fonts.inconsolata
      nerd-fonts.symbols-only
      nerd-fonts.open-dyslexic
      nerd-fonts.comic-shanns-mono
    ];

    enableDefaultPackages = false;
    fontconfig.useEmbeddedBitmaps = true;

    fontconfig.defaultFonts = {
      serif = [ "Tinos Nerd Font" ];
      sansSerif = [ "Noto Sans" ];
      monospace = [ "MonaspiceNe Nerd Font" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
