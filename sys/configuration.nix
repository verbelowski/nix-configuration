{ pkgs, vars, ... }: {
  # Component imports.
  # System configurations list.
  imports = import ../lib/import-modules.nix {
    dir = ../sys/modules;
  };

  # Software selection.
  # Global system environment packages.
  environment.systemPackages = with pkgs; [ ];

  # Maintenance configurations.
  # Scheduled system update options.
  system.autoUpgrade = {
    # Activation state.
    # Automatic upgrade enablement flag.
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
    # Automatic reboot after kernel update.
    allowReboot = true; # NOTE: `persistent` defaults to `true`, so missed weekly upgrades run on next boot.
  };

  # State identifier.
  # NixOS compatibility version string.
  system.stateVersion = vars.stateVersion;
}
