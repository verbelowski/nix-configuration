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
    # Emacs key bindings for command line editing.
    defaultKeymap = "emacs";

    # Syntax highlighting.
    # Real-time command syntax coloring.
    syntaxHighlighting.enable = true; # TODO: Switch to `fastSyntaxHighlighting` in the next release.

    # Auto suggestions.
    # History-based command completion hints.
    autosuggestion.enable = true;

    # History substring search.
    # Arrow key navigation through matching history entries.
    historySubstringSearch.enable = true;

    # History settings.
    # Command history configuration.
    history = {
      # History filtering.
      # Duplicate and space-prefixed command exclusion.
      ignoreAllDups = true;
      ignoreSpace = true;

      # Timestamps.
      # Date and time recorded for each history entry.
      extended = true;
    };

    # Shell aliases.
    # Command shorthand definitions.
    shellAliases = {
      cls = "clear";
      ls = "ls --color=auto";
    };
  };
}
