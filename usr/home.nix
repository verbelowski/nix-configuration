{ pkgs, vars, ... }: {
  # External modules.
  # User space module declarations.
  imports = import ../lib/import-modules.nix {
    dir = ../usr/modules;
  };

  # Account parameters.
  # User profile name and target directory location.
  home.username = vars.user.name;
  home.homeDirectory = "/home/${vars.user.name}";

  # User packages.
  # Individual profile binary packages.
  home.packages = with pkgs; [ ];

  # State compatibility.
  # Backwards migration release baseline.
  home.stateVersion = vars.stateVersion;
}
