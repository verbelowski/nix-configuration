{ pkgs, vars, ... }: {
  # User accounts.
  # Human operator profile definitions.
  users = {
    # Default interpreter.
    # Interactive command terminal package.
    defaultUserShell = pkgs.zsh;

    # Account configuration.
    # Primary operator identity parameters.
    users.${vars.user.name} = {
      # Account type.
      # Non-system interactive operator flag.
      isNormalUser = true;

      # Account label.
      # Formatted user identity string.
      description = vars.capitalize vars.user.name;

      # Group access.
      # Permission elevation membership list.
      extraGroups = [ "networkmanager" "wheel" ]; # TODO: Add groups as configuration grows (e.g. `audio`, `video`, `render`, `input`, `lp`).
    };
  };

  # Interactive shell.
  # Command interpreter system integration.
  programs.zsh.enable = true;
}
