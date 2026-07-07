{ pkgs, vars, ... }: {
  # User configuration.
  # Account and shell settings.
  users = {
    # Default shell.
    # System-wide login shell definition.
    defaultUserShell = pkgs.zsh;

    # User account.
    # Primary user account definition.
    users.${vars.user.name} = {
      # Account type.
      # Normal user account with home directory.
      isNormalUser = true;

      # Display name.
      # User description field value.
      description = vars.capitalize vars.user.name;

      # User groups.
      # Permission group membership list.
      extraGroups = [ "networkmanager" "wheel" ]; # TODO: Add groups as configuration grows (e.g. `audio`, `video`, `render`, `input`, `lp`).
    };
  };

  # Zsh activation.
  # System-wide Zsh login shell enablement.
  programs.zsh.enable = true;
}
