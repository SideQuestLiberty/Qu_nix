{ config, user, ... }:
# Services & dependencies for other programs configuration
{
  networking = {
    networkmanager.enable = true;
    hostName = "${user.hostname}";
    firewall.enable = true;
    # Open ports in the firewall
    firewall.allowedTCPPorts = [ 57621 ];
    firewall.allowedUDPPorts = [ 5353 ];
    # TCP:57621 - UDP:5353 => spotify-player
    #
    # Configure network proxy if necessary
    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };


  security.rtkit.enable = true;
  security.polkit.enable = true;


  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {};
    input = {};
    network = {};
  };

  services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    audio.enable = true;
    wireplumber.enable = true;
  };

  services.gvfs.enable = true;

  services.hardware.openrgb.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  #programs.mtr.enable = true;
  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #};
}
