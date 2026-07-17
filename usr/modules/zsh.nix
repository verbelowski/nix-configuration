{ ... }: {
  # Interpreter configurations.
  # Interactive shell program options.
  programs.zsh = {
    # Activation flag.
    # Program enablement state.
    enable = true;

    # Path transition.
    # Implicit directory navigation without command prefix.
    autocd = true;

    # Input mapping.
    # Emacs key binding mode for prompt editing.
    defaultKeymap = "emacs";

    # Session context.
    # Default workspace environment definitions.
    envExtra = ''
      export EDITOR=nvim
      export VISUAL=nvim
    '';

    # Visual feedback.
    # Real time command syntax coloring state.
    syntaxHighlighting.enable = true; # TODO: Switch to `fastSyntaxHighlighting` in the next release.

    # Input predictions.
    # History based command completion hint state.
    autosuggestion.enable = true;

    # Record filtering.
    # Arrow key navigation through matching history entries.
    historySubstringSearch.enable = true;

    # Transcript options.
    # Command history parameters.
    history = {
      # Record exclusion.
      # Duplicate and space prefixed command omission state.
      ignoreAllDups = true;
      ignoreSpace = true;

      # Chronological markers.
      # Per-entry date and time recording state.
      extended = true;
    };

    # Execution shorthands.
    # Command alias definitions.
    shellAliases = {
      cls = "clear";
      ls = "ls --color=auto";
    };
  };
}
