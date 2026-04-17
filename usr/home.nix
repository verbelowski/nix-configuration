{ vars, ... }: {
  # Module imports.
  # User module aggregation via dynamic loader.
  imports = import ../lib/import-modules.nix {
    # Module directory.
    # User module source path.
    dir = ../usr/modules;
  };

  # Home Manager state.
  # User configuration version compatibility reference.
  home.stateVersion = vars.stateVersion;
}
