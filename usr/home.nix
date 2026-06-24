{ pkgs, vars, ... }: {
  # Module imports.
  # User configuration modules.
  imports = import ../lib/import-modules.nix { dir = ../usr/modules; };

  # Home environment.
  # Username and home directory mapping.
  home.username = vars.user.name;
  home.homeDirectory = "/home/${vars.user.name}";

  # Package selection.
  # Additional packages in user environment.
  home.packages = with pkgs; [ ];

  # State version.
  # Home Manager compatibility version.
  home.stateVersion = vars.stateVersion;
}
