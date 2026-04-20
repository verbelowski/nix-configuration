{ vars, ... }: {
  # Module imports.
  # User module composition set.
  imports = import ../lib/import-modules.nix {
    dir = ../usr/modules;
  };

  # Home state.
  # Home Manager version baseline.
  home.stateVersion = vars.stateVersion;
}
