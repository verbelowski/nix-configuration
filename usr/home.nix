{ pkgs, vars, ... }: {
  # External modules.
  # User space component declarations.
  imports = import ../lib/import-modules.nix {
    dir = ../usr/modules;
  };

  # User environment.
  # Account home path settings.
  home.username = vars.user.name;
  home.homeDirectory = "/home/${vars.user.name}";

  # User software.
  # Individual profile binary packages.
  home.packages = with pkgs; [ ];

  # State compatibility.
  # Backwards migration release baseline.
  home.stateVersion = vars.stateVersion;
}
