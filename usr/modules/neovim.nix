{ ... }: {
  # Neovim configuration.
  # Text editor program settings.
  programs.neovim = {
    # Enable flag.
    # Program activation state.
    enable = true;

    # Default editor.
    # System-wide editor definition.
    defaultEditor = true;

    # Vi and Vim aliases.
    # Neovim as `vi` and `vim` commands.
    viAlias = true;
    vimAlias = true;
  };
}
