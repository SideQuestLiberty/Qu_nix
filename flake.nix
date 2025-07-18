{
  description = "Flake for Qu_nix, SideQuest' NixOS configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    quickshell.url = "github:quickshell-mirror/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    zen-browser,
    quickshell,
  } @ inputs :
  let user = {
    name = "Your Name!";         # Your cool name
    hostname = "yourhostname0";  # Your host name
    # Your host name should be only numbers and lowercase letters
    system = "x86_64-linux";     # Your system
    # Defined in your hardware-configuration.nix under "nixpkgs.hostPlatform"
    configPath = "/home/${user.hostname}/Qu_nix";
    # The ABSOLUTE path to this flake's parent directory
    CPflavor = "mocha";          # Your preferred catppuccin flavor
    CPaccent = "teal";           # Your preferred catppuccin accent
    # These two variables must be lowercase. You can find
    # all flavors & accents at https://github.com/catppuccin/catppuccin.
  };
  in {
    nixosConfigurations.Qu_nix = nixpkgs.lib.nixosSystem {
      system = "${user.system}";
      specialArgs = { inherit user inputs; };
      modules = [
        ./NixOS/global.nix
      ];
    };
  };
}
