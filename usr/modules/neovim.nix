{ ... }: {
  # Text editor.
  # Terminal-based source code interface.
  programs.neovim = {
    # Editor activation.
    # Neovim application switch.
    enable = true;

    # Primary editor.
    # Environment text modification tool.
    defaultEditor = true;

    # Binary shortcuts.
    # Executable command wrappers.
    viAlias = true;
    vimAlias = true;

    # Initialization script.
    # Embedded Lua environment configuration.
    initLua = ''
      -- Line indicators.
      -- Sequential margin number visibility.
      vim.opt.number = true

      -- Buffer markers.
      -- Unused workspace symbol suppression.
      vim.opt.fillchars = { eob = " " }

      -- Indentation width.
      -- Code structure offset rules.
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      -- Cursor position.
      -- Active line highlight mode.
      vim.opt.cursorline = true

      -- Edit history.
      -- Persistent change storage.
      vim.opt.undofile = true

      -- Search sensitivity.
      -- Character casing query behavior.
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
    '';
  };
}
