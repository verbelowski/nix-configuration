{
  # Module imports.
  # User module aggregation via dynamic loader.
  imports = import ../lib/import-modules.nix {
    # Module directory.
    # User module source path.
    dir = ../usr/modules;
  };
}
