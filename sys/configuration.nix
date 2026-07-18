{ pkgs, vars, ... }: {
  # Component imports.
  # System configuration lists.
  imports = import ../lib/import-modules.nix {
    dir = ../sys/modules;
  };

  # Software selection.
  # Global system environment packages.
  environment.systemPackages = with pkgs; [ ];

  # Maintenance configuration.
  # Scheduled system update options.
  system.autoUpgrade = {
    # Enablement state.
    # Automatic upgrade activation flags.
    enable = true;

    # Execution schedule.
    # Weekly upgrade interval definitions.
    dates = "weekly";

    # Repository reference.
    # Source path for automatic upgrades.
    flake = "/home/${vars.user.name}/nix-configuration#nixos";

    # Compilation flags.
    # Rebuild command execution arguments.
    flags = [ "--update-input" "nixpkgs" "--update-input" "home-manager" ];

    # Restart permission.
    # Automatic reboot after kernel updates.
    allowReboot = true; # NOTE: `persistent` defaults to `true`, so missed weekly upgrades run on next boot.
  };

  # State identifier.
  # NixOS compatibility version strings.
  system.stateVersion = vars.stateVersion;
}
