{ vars, ... }: {
  # Module imports.
  # System module aggregation via dynamic loader.
  imports = import ../lib/import-modules.nix {
    # Module directory.
    # System module source path.
    dir = ../sys/modules;
  };

  # NixOS state.
  # System configuration version compatibility reference.
  system.stateVersion = vars.stateVersion;
}
