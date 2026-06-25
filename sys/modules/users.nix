{ pkgs, lib, vars, ... }: let
  # Helper functions.
  # Imported utility functions.
  helpers = import ../../lib/helper-functions.nix { inherit lib; };
in {
  # User configuration.
  # Account and shell settings.
  users = {
    # Default shell.
    # System-wide shell definition.
    defaultUserShell = pkgs.zsh;

    # User account.
    # Primary user definition.
    users.${vars.user.name} = {
      # Account type.
      # Normal user with home directory.
      isNormalUser = true;

      # Display name.
      # User description field.
      description = helpers.capitalize vars.user.name;

      # User groups.
      # Permission group membership.
      extraGroups = [ "wheel" ]; # TODO: Add groups as configuration grows (e.g. `networkmanager`, `video`, `audio`, `input`).
    };
  };

  # Zsh activation.
  # Shell availability in system environment.
  programs.zsh.enable = true; # NOTE: User configuration managed by Home Manager in `usr/modules/zsh.nix`.
}
