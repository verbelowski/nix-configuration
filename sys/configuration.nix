{ vars, ... }: {
  # Module imports.
  # System configuration modules.
  imports = import ../lib/import-modules.nix {
    dir = ../sys/modules;
  };

  # State version.
  # NixOS compatibility version.
  system.stateVersion = vars.stateVersion;
}
