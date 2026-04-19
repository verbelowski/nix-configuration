{ vars, ... }: {
  # Module imports.
  # System module composition set.
  imports = import ../lib/import-modules.nix {
    # Module directory.
    # System modules path reference.
    dir = ../sys/modules;
  };

  # System state.
  # NixOS version baseline.
  system.stateVersion = vars.stateVersion;
}
