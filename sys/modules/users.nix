{ pkgs, vars, ... }: {
  # User accounts.
  # Human operator profile definitions.
  users = {
    # Default shell.
    # Command line interactive interpreter.
    defaultUserShell = pkgs.zsh;

    # Main account.
    # Primary human operator profile.
    users.${vars.user.name} = {
      # Account classification.
      # Non-system interactive identity flag.
      isNormalUser = true;

      # Display name.
      # Human-readable profile label metadata.
      description = vars.capitalize vars.user.name;

      # Group memberships.
      # Privilege access vector assignments.
      extraGroups = [ "networkmanager" "wheel" ]; # TODO: Add groups as configuration grows (e.g. `audio`, `video`, `render`, `input`, `lp`).
    };
  };

  # Shell interpreter.
  # Interactive terminal session environment.
  programs.zsh.enable = true;
}
