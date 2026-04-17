{ pkgs, vars, ... }: {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  users.users.vertennn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.systemPackages = with pkgs; [ neovim ];

  virtualisation.vmware.guest.enable = true;

  system.stateVersion = vars.stateVersion;
}
