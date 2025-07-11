{ config, pkgs, user, ... }:

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
}
