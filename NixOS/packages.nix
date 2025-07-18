{ config, pkgs, user, inputs, ... }:
# Packages configuration
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
        rebuild = "sudo nixos-rebuild boot --flake ${user.configPath}#Qu_nix";
      };
    };
    hyprland = {
      enable = true;                         # Smooth Wayland tiling compositor
      xwayland.enable = true;
      withUWSM = true;
    };
    neovim = {
      enable = true;                               # Productive terminal editor
      defaultEditor = false;
      viAlias = true;
      vimAlias = true;
    };
    firefox = {
      enable = true;                                # Browser, privacy included
      package = pkgs.librewolf;
      policies = import ./../Firefox/policies.nix; # TODO: make this work
    };
    steam = {
      enable = true;                          # Game store / library / launcher
      extraPackages = [ pkgs.gamescope ];
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    gamescope = {             # Launch an environment similar to the Steam deck
      enable = true;
      capSysNice = true;
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
    fromInputs = pkgName:
      inputs."${pkgName}".packages."${user.system}".default;
  in [
    ### NEEDED AS DEPENDENCIES                       NEEDED AS DEPENDENCIES ###
    nvidia-vaapi-driver                 # Video-Audio hardware acceleration API
    egl-wayland                        # NVidia EGL support library for Wayland
    hyprpolkitagent           # Polkit agent: allows apps to elevate privileges

    ### BASIC SOFTWARE                                       BASIC SOFTWARE ###
    kitty                                      # Customizable terminal emulator
    nemo-with-extensions                 # Customizable file explorer from Mint
    albert                                  # Minimalistic application launcher
    ente-auth                                            # Free secured 2FA app
    proton-pass                                # Private, free Password Manager
    protonvpn-cli                                           # Private, free VPN
    zed-editor-fhs            # Fast, Reliable, Feature-Rich (frfr) text editor
    obsidian                                      # Featureful notes-taking app
    oculante                                            # Image viewer & editor
    beeper                                                 # Universal chat app
    vesktop    # Vencord faster, lighter, privater, screensharer discord client
    freetube       # TEST (also test redirect extension) Private youtube client
    spotify-player                             # Terminal music player & Daemon
    cemu                                   # Highly configurable Wii-U emulator
    ukmm                                              # Zelda: BotW mod manager
    prismlauncher                                 # Minecraft instances manager
    ffmpeg-full                      # Anything you would need to handle videos
    lxqt.qps                                         # Process viewer & manager
    mangohud                                 # FPS, Heat & CPU/GPU load Overlay
    fastfetch                            # Fetch and display system information
    catppuccinifier-cli                         # Apply color palette to images
    (inputs.zen-browser.packages."${user.system}".beta-unwrapped.override {
      applicationName = "Zen Browser";                  # Gecko Sidebar Browser
      policies = import ./../Firefox/policies.nix;
    })

    ### UTILITIES                                                 UTILITIES ###
    (fromInputs "quickshell")                            # DIY Qt widget system
    dunst                       # Lightwheight customizable notification Daemon
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
      serif = ["Tinos Nerd Font"];
      sansSerif = ["Noto Sans"];
      monospace = ["MonaspiceNe Nerd Font"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
