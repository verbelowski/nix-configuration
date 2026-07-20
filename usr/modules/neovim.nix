{ ... }: {
  # Editor configuration.
  # Text manipulation program options.
  programs.neovim = {
    # Enablement state.
    # Program activation flags.
    enable = true;

    # Primary workspace.
    # System-wide editor definitions.
    defaultEditor = true;

    # Command aliases.
    # Neovim substitution for legacy commands.
    viAlias = true;
    vimAlias = true;

    # Script configuration.
    # Editor appearance and behavior parameters.
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
