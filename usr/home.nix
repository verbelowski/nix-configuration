{ vars, ... }: {
  # Module imports.
  # User modules.
  imports = import ../lib/import-modules.nix {
    # Module directory.
    # User modules path.
    dir = ../usr/modules;
  };

  # Home state version.
  # Home Manager compatibility baseline.
  home.stateVersion = vars.stateVersion;
}
