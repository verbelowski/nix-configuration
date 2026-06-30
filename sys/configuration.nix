{ pkgs, vars, ... }: {
  # Module imports.
  # System configuration module list.
  imports = import ../lib/import-modules.nix {
    dir = ../sys/modules;
  };

  # Package selection.
  # Additional system environment packages.
  environment.systemPackages = with pkgs; [ ];

  # Automatic upgrade.
  # Scheduled system update settings.
  system.autoUpgrade = {
    # Enable flag.
    # Automatic upgrade activation state.
    enable = true;

    # Update schedule.
    # Weekly upgrade interval definition.
    dates = "weekly";

    # Flake reference.
    # Configuration source for automatic upgrades.
    flake = "/home/${vars.user.name}/nix-configuration#nixos";

    # Rebuild flags.
    # Additional rebuild command arguments.
    flags = [ "--update-input" "nixpkgs" "--update-input" "home-manager" "-L" ];

    # Reboot permission.
    # Automatic restart after kernel update.
    allowReboot = true; # NOTE: `persistent` defaults to true, so missed weekly upgrades run on next boot.
  };

  # State version.
  # NixOS compatibility version identifier.
  system.stateVersion = vars.stateVersion;
}
