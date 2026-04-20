{ vars, ... }: {
  # Module imports.
  # System module loading from external directory.
  imports = import ../lib/import-modules.nix {
    dir = ../sys/modules;
  };

  # State version.
  # System compatibility version reference.
  system.stateVersion = vars.stateVersion;
}
