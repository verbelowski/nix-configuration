{ ... }: {
  # Zsh configuration.
  # Interactive shell program settings.
  programs.zsh = {
    # Enable flag.
    # Program activation state.
    enable = true;

    # Auto CD.
    # Implicit directory navigation without `cd` command.
    autocd = true;

    # Default keymap.
    # Emacs key binding mode for command line editing.
    defaultKeymap = "emacs";

    # Syntax highlighting.
    # Real-time command syntax coloring state.
    syntaxHighlighting.enable = true; # TODO: Switch to `fastSyntaxHighlighting` in the next release.

    # Auto suggestions.
    # History-based command completion hint state.
    autosuggestion.enable = true;

    # History substring search.
    # Arrow key navigation through matching history entries.
    historySubstringSearch.enable = true;

    # History settings.
    # Command history configuration options.
    history = {
      # History filtering.
      # Duplicate and space-prefixed command exclusion state.
      ignoreAllDups = true;
      ignoreSpace = true;

      # Timestamps.
      # Per-entry date and time recording state.
      extended = true;
    };

    # Shell aliases.
    # Command shorthand definition map.
    shellAliases = {
      cls = "clear";
      ls = "ls --color=auto";
    };
  };
}
