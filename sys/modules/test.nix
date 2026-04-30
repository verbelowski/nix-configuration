{ pkgs, ... }: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.networkmanager.enable = true;

  users.users.vertennn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  virtualisation.vmware.guest.enable = true;
}
