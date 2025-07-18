{ config, lib, ... }:
# NVidia support configuration
{
  services.xserver.videoDrivers = ["nvidia"];

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  hardware = {
    # Enable OpenGL
    graphics.enable = true;
    graphics.enable32Bit = true;

    nvidia = {
      # Use the NVidia open-source kernel module (not to be confused with
      # the 3rd-party fully open-source "nouveau" driver).
      open = true;
      # Enable the NVidia settings menu accessible via nvidia-settings
      nvidiaSettings = true;
      # Use the latest stable production package
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Enable kernel modesetting which makes the driver provide
      # its own framebuffer device, which can help Wayland compositors.
      modesetting.enable = true;

      # Enables a daemon (nvidia-powerd) running when plugged
      # that redirects power either to the GPU or to the CPU
      # depending on their power usage, which should help performance.
      dynamicBoost.enable = true;


      # Enable if graphical corruption / crashes after sleep mode
      powerManagement.enable = false;
      powerManagement.finegrained = false;

      # NVidia Optimus PRIME switches between integrated Intel graphics and
      # discrete NVidia GPU for better performances while keeping battery life.
      prime = {
        # Bus IDs for Intel and NVidia GPUs
        intelBusId  = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
        # Sync Mode reduces screen tearing and offers continuous performances
        # but uses more power (the GPU never sleeps).
        sync.enable = lib.mkDefault true;
      };
    };
  };

  # The specialisation system allows you to rebuild different configs.
  # The normal config is used when plugged and sets PRIME to sync mode.
  # The portable specialisation, defined below, sets PRIME to offload mode.
  specialisation.portable = {
    inheritParentConfig = true;
    configuration = {
      system.nixos.tags = [ "portable" ];
      hardware.nvidia.prime = {
        sync.enable = false;
        # Offload Mode puts the GPU to sleep for battery live unless
        # explicitely called to run a program: "nvidia-offload-run <program>".
        offload = {
          enable = true;
          # Enables a command to call the GPU for this program.
          enableOffloadCmd = true;
          offloadCmdMainProgram = "nvidia-offload-run";
        };
      };
    };
  };
}
