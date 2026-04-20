{ vars, ... }: {
  # Module imports.
  # Home module loading from external directory.
  imports = import ../lib/import-modules.nix {
    dir = ../usr/modules;
  };

  # State version.
  # Home Manager compatibility version reference.
  home.stateVersion = vars.stateVersion;
}
