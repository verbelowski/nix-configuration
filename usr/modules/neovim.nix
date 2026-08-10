{ ... }: {
  # Text editor.
  # Command-line code environment setup.
  programs.neovim = {
    # Editor activation.
    # Neovim application switch.
    enable = true;

    # Default editor.
    # System-wide primary text modification switch.
    defaultEditor = true;

    # Binary shortcuts.
    # Legacy execution command compatibility wrappers.
    viAlias = true;
    vimAlias = true;

    # Initialization script.
    # Embedded Lua environment configuration.
    initLua = ''
      -- Line indicators.
      -- Sequential number visibility settings.
      vim.opt.number = true

      -- Buffer markers.
      -- End-of-file tilde character suppression definitions.
      vim.opt.fillchars = { eob = " " }

      -- Indentation width.
      -- Tab and shift character count values.
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true

      -- Cursor position.
      -- Active line highlight display settings.
      vim.opt.cursorline = true

      -- Edit history.
      -- Persistent undo file storage settings.
      vim.opt.undofile = true

      -- Search sensitivity.
      -- Case matching and smart override modes.
      vim.opt.ignorecase = true
      vim.opt.smartcase = true
    '';
  };
}
