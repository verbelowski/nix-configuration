{ pkgs, vars, ... }: {
  # External modules.
  # User space component declarations.
  imports = import ../lib/import-modules.nix {
    dir = ../usr/modules;
  };

  # Account parameters.
  # User space path specifications.
  home.username = vars.user.name;
  home.homeDirectory = "/home/${vars.user.name}";

  # User packages.
  # Individual profile binary executables.
  home.packages = with pkgs; [ ];

  # State compatibility.
  # Backwards migration release baseline.
  home.stateVersion = vars.stateVersion;
}
