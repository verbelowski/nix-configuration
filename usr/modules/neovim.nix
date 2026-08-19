{ ... }: {
  # Text editor.
  # Terminal-based source code interface.
  programs.neovim = {
    # Editor activation.
    # Neovim application switch.
    enable = true;

    # Default editor.
    # Primary text modification tool.
    defaultEditor = true;

    # Binary shortcuts.
    # Legacy execution command wrappers.
    viAlias = true;
    vimAlias = true;

    # Initialization script.
    # Embedded Lua environment configuration.
    initLua = ''
      -- Line indicators.
      -- Sequential number visibility settings.
      vim.opt.number = true

      -- Buffer markers.
      -- Trailing workspace symbol suppression.
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
      -- Persistent change history storage.
      vim.opt.undofile = true

      -- Search sensitivity.
      -- Character casing query behavior.
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
    '';
  };
}
