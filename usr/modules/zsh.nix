{ ... }: {
  # Command interpreter.
  # Interactive terminal session customization.
  programs.zsh = {
    # Zsh activation.
    # Interactive shell environment switch.
    enable = true;

    # Directory navigation.
    # Implicit path movement behavior.
    autocd = true;

    # Keybindings mode.
    # Line editor keymap profile.
    defaultKeymap = "emacs";

    # Environment variables.
    # Shell startup exports.
    envExtra = ''
      export EDITOR=nvim
      export VISUAL=nvim
    '';

    # Syntax highlighting.
    # Command line colorization engine.
    syntaxHighlighting.enable = true; # TODO: Switch to `fastSyntaxHighlighting` in the next release.

    # Auto-suggestions.
    # Command history prediction engine.
    autosuggestion.enable = true;

    # Substring search.
    # Partial command matching utility.
    historySubstringSearch.enable = true;

    # Command history.
    # Interactive session storage parameters.
    history = {
      # Duplicate suppression.
      # Consecutive filter and leading whitespace exclusion flags.
      ignoreAllDups = true;
      ignoreSpace = true;

      # Timestamp metadata.
      # Execution time logging mode.
      extended = true;
    };

    # Command aliases.
    # Terminal shortcut definition list.
    shellAliases = {
      cls = "clear";
      ls = "ls --color=auto";
    };
  };
}
