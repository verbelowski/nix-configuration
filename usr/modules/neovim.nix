{ ... }: {
  # Editor configurations.
  # Text manipulation program options.
  programs.neovim = {
    # Activation flag.
    # Program enablement state.
    enable = true;

    # Primary workspace.
    # System wide editor definitions.
    defaultEditor = true;

    # Command aliases.
    # Neovim substitution for legacy commands.
    viAlias = true;
    vimAlias = true;

    # Script configurations.
    # Editor appearance and behavior parameters.
    initLua = ''
      -- Line numbers
      vim.opt.number = true

      -- Empty line markers
      vim.opt.fillchars = { eob = " " }

      -- Indentation
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      -- Cursor line highlight
      vim.opt.cursorline = true

      -- Persistent undo history
      vim.opt.undofile = true

      -- Case-insensitive search
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
    '';
  };
}
