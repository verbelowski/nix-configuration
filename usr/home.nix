{ vars, ... }: {
  # Module imports.
  # User module composition set.
  imports = import ../lib/import-modules.nix {
    # Module directory.
    # User modules path reference.
    dir = ../usr/modules;
  };

  # Home state.
  # Home Manager version baseline.
  home.stateVersion = vars.stateVersion;
}
