{ vars, ... }: {
  # Git configuration.
  # Version control program settings.
  programs.git = {
    # Enable flag.
    # Program activation state.
    enable = true;

    # Git settings.
    # https://git-scm.com/docs/git-config
    settings = {
      # User identity.
      # Commit author metadata fields.
      user = {
        # Identity fields.
        # Commit author name and email values.
        name = vars.capitalize vars.user.name;
        email = vars.user.email;

        # Signing key.
        # SSH key for commit signature verification.
        signingKey = "~/.ssh/id_ed25519_sign.pub";

        # Identity restriction.
        # Config-file-only identity value enforcement.
        useConfigOnly = true;
      };

      # Repository safety.
      # Trusted directory path definition.
      safe.directory = "*";

      # Commit signature.
      # SSH format and trusted signers file path.
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };

      # Commit signing.
      # Automatic commit signature generation state.
      commit.gpgSign = true;

      # Tag signing.
      # Automatic tag signature generation state.
      tag.gpgSign = true;

      # Core options.
      # Editor and line ending configuration.
      core = {
        editor = "nvim";
        autocrlf = "input";
      };

      # Repository init.
      # Default branch name definition.
      init.defaultBranch = "main";

      # URL rewrite rule.
      # GitHub SSH access over HTTPS substitution.
      url."git@github.com:".insteadOf = "https://github.com/";

      # Fetch policy.
      # Remote branch pruning configuration.
      fetch.prune = true;

      # Pull policy.
      # Linear history rebase configuration.
      pull.rebase = true;

      # Push policy.
      # Remote update and authentication settings.
      push = {
        # Default push mode.
        # Simple push strategy definition.
        default = "simple";
        autoSetupRemote = true;

        # Tag propagation.
        # Remote tag synchronization state.
        followTags = true;
      };

      # Rebase policy.
      # History rewriting configuration settings.
      rebase = {
        # Local state handling.
        # Automatic stash and squash state.
        autoStash = true;
        autoSquash = true;

        # Reference updates.
        # Branch reference adjustment state.
        updateRefs = true;
      };

      # Merge options.
      # Rename detection and conflict style settings.
      merge = {
        renames = true;
        conflictStyle = "zdiff3";
      };

      # Diff options.
      # Histogram comparison algorithm selection.
      diff.algorithm = "histogram";
    };
  };
}
