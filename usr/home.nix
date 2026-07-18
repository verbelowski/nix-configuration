{ pkgs, vars, ... }: {
  # Component imports.
  # User configuration lists.
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
  # Home Manager compatibility version strings.
  home.stateVersion = vars.stateVersion;
}
