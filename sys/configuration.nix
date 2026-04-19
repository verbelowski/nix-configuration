{ vars, ... }: {
  # Module imports.
  # System modules.
  imports = import ../lib/import-modules.nix {
    # Module directory.
    # System modules path.
    dir = ../sys/modules;
  };

  # System state version.
  # NixOS compatibility baseline.
  system.stateVersion = vars.stateVersion;
}
