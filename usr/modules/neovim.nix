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

    # Lua configuration.
    # Editor appearance and behavior settings.
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

      -- Clipboard synchronization
      vim.opt.clipboard = "unnamedplus"
    '';
  };
}
