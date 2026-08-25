{ ... }: {
  # Command interpreter.
  # Interactive terminal session customization.
  programs.zsh = {
    # Shell activation.
    # Zsh environment switch.
    enable = true;

    # Path movement.
    # Implicit directory navigation behavior.
    autocd = true;

    # Keybindings mode.
    # Line editor keymap profile.
    defaultKeymap = "emacs";

    # Session environment.
    # Context variable exports.
    envExtra = ''
      export EDITOR=nvim
      export VISUAL=nvim
    '';

    # Command colorization.
    # Real-time line syntax highlight.
    syntaxHighlighting.enable = true; # TODO: Switch to `fastSyntaxHighlighting` in the 26.11 release.

    # Command prediction.
    # History entry suggestion engine.
    autosuggestion.enable = true;

    # Substring search.
    # Partial command lookup utility.
    historySubstringSearch.enable = true;

    # History parameters.
    # Interactive session log options.
    history = {
      # Duplicate exclusion.
      # Repeated entry suppression flags.
      ignoreAllDups = true;
      ignoreSpace = true;

      # Execution metadata.
      # Command timestamp record mode.
      extended = true;
    };

    # Shortcut definitions.
    # Terminal command substitution aliases.
    shellAliases = {
      reboot = "sudo reboot --no-wall";
      shutdown = "sudo shutdown --no-wall now";
    };
  };
}
