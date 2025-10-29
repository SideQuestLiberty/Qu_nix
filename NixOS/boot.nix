{
  lib,
  config,
  pkgs,
  user,
  ...
}:
# Boot sequence configuration & theming
{
  # Grub2 Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 3;
    grub = {
      enable = true;
      efiSupport = true;
      enableCryptodisk = true;
      useOSProber = false;
      device = "nodev";
      theme = (pkgs.catppuccin-grub.override { flavor = user.CPflavor; });
      splashImage = ./../wallpapers/snowman-mocha.png;
    };
  };

  # Plymouth splashscreen
  boot.plymouth = {
    enable = true;
    theme = "catppuccin-${user.CPflavor}";
    themePackages = [
      (pkgs.catppuccin-plymouth.override { variant = user.CPflavor; })
    ];
  };

  boot.kernelParams = [
    # Allows Plymouth to display its screen
    "splash"
    # Opens a shell if the boot process failed
    "boot.shell_on_fail"
    # Enable "Silent boot"
    "quiet"
    # Error messages are still displayed
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
  ];
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 3;

  # Create the config file for hyprland
  environment.etc.greetd-hyprland = {
    # Write <text> to an immutable file in the /nix/store/
    text = ''
      monitor = eDP-1, 1920x1080@60, 0x0, 1

      exec-once = ${config.programs.regreet.package}/bin/regreet; hyprctl dispatch exit

      input:kb_layout = fr

      misc:background_color = rgb(11111b)
      misc:disable_hyprland_logo = true
      misc:disable_splash_rendering = true

      ecosystem:no_update_news = true

      general:layout = master
      animations:enabled = false

      opengl:nvidia_anti_flicker = true

      bindel = ,XF86MonBrightnessUp,   exec, brightnessctl s 10%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-
    '';
    # Symlink to the file at /etc/greetd/hyprland.conf
    target = "greetd/hyprland.conf";
  };

  # Use greetd login screen ("display manager") interface
  services.greetd = {
    enable = true;
    vt = 1;
    settings.default_session = {
      command = "Hyprland --config /etc/${config.environment.etc.greetd-hyprland.target}";
      user = "greeter";
    };
  };

  # Link the wallpaper for ReGreet
  environment.etc.greetd-wallpaper = {
    # Make the sourced file immutable as part of the /nix/store/
    source = ./../wallpapers/snowman-mocha.png;
    # Symlink to it at /etc/greetd/wallpaper.jpg
    target = "greetd/wallpaper.png";
  };

  # Use ReGreet greetd graphical user interface ("greeter")
  programs.regreet = {
    enable = true;
    package = pkgs.greetd.regreet;

    # Customization & theming, converted to /etc/greetd/regreet.toml
    # The packages for the themes and font are in ./customization.nix
    theme.name = "catppuccin-${user.CPflavor}-${user.CPaccent}-standard";
    cursorTheme.name = "Catppuccin ${lib.toSentenceCase user.CPflavor} Light";
    iconTheme.name = "Papirus-Dark";
    font = {
      name = "MonaspiceXe Nerd Font";
      size = 14;
    };
    settings = {
      GTK.application_prefer_dark_theme = true;
      appearance.greeting_msg = "Welcome Back, ${user.name}.";
      background = {
        path = "/etc/${config.environment.etc.greetd-wallpaper.target}";
        fit = "Fill";
      };
      # Example clock formatting : "Sun, Dec 31 - 23:59"
      widget.clock = {
        format = "%a, %b %d - %H:%M";
        resolution = "1000ms";
        timezone = "Europe/Paris";
        label_width = 300;
      };
    };
  };
}
