{ pkgs, vars, ... }: {
  # Component imports.
  # User configurations list.
  imports = import ../lib/import-modules.nix {
    dir = ../usr/modules;
  };

  # Workspace context.
  # Username and root directory mappings.
  home.username = vars.user.name;
  home.homeDirectory = "/home/${vars.user.name}";

  # Software selection.
  # Global user environment packages.
  home.packages = with pkgs; [ ];

  # State identifier.
  # Home Manager compatibility version string.
  home.stateVersion = vars.stateVersion;
}
