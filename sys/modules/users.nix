{ pkgs, vars, ... }: {
  # Account records.
  # User profile definitions.
  users = {
    # Default shell.
    # Command interpreter package selection.
    defaultUserShell = pkgs.zsh;

    # Identity parameters.
    # Primary user profile details.
    users.${vars.user.name} = {
      # Account type.
      # Non-system interactive profile flag.
      isNormalUser = true;

      # Account label.
      # Formatted text representation.
      description = vars.capitalize vars.user.name;

      # Group access.
      # Permission elevation membership list.
      extraGroups = [ "networkmanager" "wheel" ]; # TODO: Add groups as configuration grows (e.g. `audio`, `video`, `render`, `input`, `lp`).
    };
  };

  # Shell integration.
  # Interactive session system integration.
  programs.zsh.enable = true;
}
