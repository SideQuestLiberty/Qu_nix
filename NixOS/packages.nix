{ config, pkgs, user, inputs, ... }:

{
  # Configuration of the Package Manager (nix)
  nix = {
    channel.enable = false;
    optimise.automatic = true;
    optimise.dates = ["monthly"];
    gc.automatic = true;
    gc.dates = "monthly";
    # Enable Flakes
    settings.experimental-features = ["nix-command"  "flakes"];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Configure packages installed in system profile
  programs = {
    bash = {
      undistractMe.enable = true;
      undistractMe.timeout = 60;
      completion.enable = true;
      shellAliases = {
        config = "zeditor ${user.configPath}; exit";
        rebuild = "sudo nixos-rebuild boot --upgrade --flake ${user.configPath}#${user.hostname}";
      };
    };
    hyprland = {
      enable = true;                         # Smooth Wayland tiling compositor
      xwayland.enable = true;
      withUWSM = true;
    };
    river = {
      enable = true;                   # Customizable Wayland tiling compositor
      xwayland.enable = true;
      extraPackages = [  ];
    };
    neovim = {
      enable = true;                               # Productive terminal editor
      defaultEditor = false;
      viAlias = true;
      vimAlias = true;
    };
    firefox = {
      enable = true;                                # Browser, privacy included
      package = pkgs.firefox-devedition;
      policies = import ./firefox-policies.nix;
      preferences = import ./firefox-preferences.nix;
    };
    steam = {
      enable = true;                          # Game store / library / launcher
      extraPackages = [ pkgs.gamescope ];
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    gamemode = {
      enable = true;                               # System optimizer for Games
      enableRenice = true;
    };
    obs-studio = {
      enable = true;                                 # Screen recording utility
      plugins = with pkgs.obs-studio-plugins; [
          obs-vaapi                # Enable GPU Hardware encoder through NVidia
          input-overlay                    # Overlays input on top of recording
          obs-backgroundremoval   # Replace background in portait video & image
      ];
    };
    file-roller.enable = true;                     # File archiver and unzipper
    git.enable = true;                                # Version control utility
  };


  environment.systemPackages = with pkgs;
  let
    fromInputs = { pkgName, pkgVersion ? "default" }:
      inputs."${pkgName}".packages."${user.system}"."${pkgVersion}";
  in [
    ### NEEDED AS DEPENDENCIES                       NEEDED AS DEPENDENCIES ###
    nvidia-vaapi-driver                 # Video-Audio hardware acceleration API
    egl-wayland                        # NVidia EGL support library for Wayland
    hyprpolkitagent           # Polkit agent: allows apps to elevate privileges

    ### BASIC SOFTWARE                                       BASIC SOFTWARE ###
    kitty                                      # Customizable terminal emulator
    nemo-with-extensions                 # Customizable file explorer from Mint
    albert                                  # Minimalistic application launcher
    zed-editor                # Fast, Reliable, Feature-Rich (frfr) text editor
    obsidian                                      # Featureful notes-taking app
    oculante                                            # Image viewer & editor
    beeper                                                 # Universal chat app
    vesktop    # Vencord faster, lighter, privater, screensharer discord client
    freetube       # TEST (also test redirect extension) Private youtube client
    spotify-player                             # Terminal music player & Daemon
    prismlauncher                                 # Minecraft instances manager
    lxqt.qps                                         # Process viewer & manager
    mangohud                                 # FPS, Heat & CPU/GPU load Overlay
    fastfetch                            # Fetch and display system information
    catppuccinifier-cli                         # Apply color palette to images
    ((
      fromInputs { pkgName = "zen-browser"; pkgVersion = "beta-unwrapped"; }
    ).override {
      applicationName = "Zen Browser";                  # Gecko Sidebar Browser
      policies = import ./firefox-policies.nix;
    })

    ### UTILITIES                                                 UTILITIES ###
    dunst                       # Lightwheight customizable notification Daemon
    (fromInputs { pkgName = "quickshell"; })             # DIY Qt widget system
    swaylock-effects                                   # Screen locking utility
    swaybg                                             # Basic wallpaper Daemon
    swww                                            # Animated wallpaper Daemon
    copyq                       # Clipboard manager (can integrate with albert)
    slurp                                 # Screenshot region selecting utility
    grim                                           # Screenshot capture utility
    swappy                                         # Screenshot editing utility
    wl-clipboard                         # Needed for swappy, clipboard utility
    brightnessctl                             # Screen backlight control Daemon
    wl-gammactl                   # Brightness, contrast & gamma control Daemon
    hyprlang                                  # Hyprland configuration language

    ### CUSTOMIZATION                                         CUSTOMIZATION ###
    papirus-icon-theme                                 # Icon theme with extras
    catppuccin-cursors."${user.CP-flavor}Light"# Soothing pastel themed cursors
    (catppuccin-gtk.override {                 # Soothing pastel themes for GTK
      variant = user.CP-flavor;
      accents = [ user.CP-accent ];
    })
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
      serif = ["Noto Serif"];
      sansSerif = ["Noto Sans"];
      monospace = ["Hack"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
