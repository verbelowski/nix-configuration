{ pkgs, vars, ... }: {
  # External modules.
  # Hardware structural component declarations.
  imports = import ../lib/import-modules.nix {
    dir = ../sys/modules;
  };

  # System software.
  # Globally accessible binary packages.
  environment.systemPackages = with pkgs; [ ];

  # Automatic upgrades.
  # Scheduled system rebuild routine.
  system.autoUpgrade = {
    # Service activation.
    # Background daemon execution switch.
    enable = true;

    # Execution schedule.
    # Maintenance interval timing specification.
    dates = "weekly";

    # Target path.
    # Flake repository configuration location.
    flake = "/home/${vars.user.name}/nix-configuration#nixos";

    # Update parameters.
    # Lockfile input revision arguments.
    flags = [ "--update-input" "nixpkgs" "--update-input" "home-manager" ];

    # Automatic reboot.
    # Post-update power cycle authorization.
    allowReboot = true; # NOTE: `persistent` defaults to `true`, so missed weekly upgrades run on next boot.
  };

  # State compatibility.
  # Backwards migration release baseline.
  system.stateVersion = vars.stateVersion;
}
