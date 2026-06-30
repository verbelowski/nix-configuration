{ pkgs, vars, ... }: {
  # Module imports.
  # User configuration module list.
  imports = import ../lib/import-modules.nix {
    dir = ../usr/modules;
  };

  # Home environment.
  # Username and home directory mapping.
  home.username = vars.user.name;
  home.homeDirectory = "/home/${vars.user.name}";

  # Package selection.
  # Additional user environment packages.
  home.packages = with pkgs; [ neovim ];

  # Session variables.
  # User environment variable definitions.
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # State version.
  # Home Manager compatibility version identifier.
  home.stateVersion = vars.stateVersion;
}
