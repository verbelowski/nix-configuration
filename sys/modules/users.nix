{ pkgs, vars, ... }: {
  # Identity configurations.
  # Account and shell options.
  users = {
    # Primary interpreter.
    # System wide login shell definitions.
    defaultUserShell = pkgs.zsh;

    # Personal account.
    # Primary profile definitions.
    users.${vars.user.name} = {
      # Privilege level.
      # Normal user profile with home directory.
      isNormalUser = true;

      # Visual moniker.
      # Profile description field value.
      description = vars.capitalize vars.user.name;

      # Access rings.
      # Permission group membership list.
      extraGroups = [ "networkmanager" "wheel" ]; # TODO: Add groups as configuration grows (e.g. `audio`, `video`, `render`, `input`, `lp`).
    };
  };

  # Interpreter activation.
  # System wide Zsh login shell enablement.
  programs.zsh.enable = true;
}
