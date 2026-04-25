{ vars, ... }: {
  # Module imports.
  # User configuration modules.
  imports = import ../lib/import-modules.nix {
    dir = ../usr/modules;
  };

  # State version.
  # Home Manager compatibility version.
  home.stateVersion = vars.stateVersion;
}
