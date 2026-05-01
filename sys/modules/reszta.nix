{ ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.vertennn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  virtualisation.vmware.guest.enable = true;
}
