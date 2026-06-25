{ ... }: {
  # Zsh configuration.
  # Program entry definition.
  programs.zsh = {
    # Enable flag.
    # Program activation state.
    enable = true;

    # Auto CD.
    # Directory navigation without `cd` command.
    autocd = true;

    # Default keymap.
    # Vi insert mode key bindings for command line editing.
    defaultKeymap = "viins";

    # Syntax highlighting.
    # Real-time command syntax coloring.
    syntaxHighlighting.enable = true;

    # Auto suggestions.
    # History-based command completion hints.
    autosuggestion.enable = true;

    # Shell aliases.
    # Command shorthand definitions.
    shellAliases = {
      cls = "clear";
      ls = "ls --color=auto";
    };
  };
}
