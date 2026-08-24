{ vars, ... }: {
  # Version control.
  # Source code revision history.
  programs.git = {
    # Git activation.
    # Source management subsystem switch.
    enable = true;

    # Repository settings.
    # Central software workspace options.
    settings = {
      # Commit author.
      # Developer identity metadata defaults.
      user = {
        # Author identity.
        # User profile contact parameters.
        name = vars.capitalize vars.user.name;
        email = vars.user.email;

        # Signature key.
        # Public SSH file path.
        signingKey = "~/.ssh/id_ed25519_sign.pub";

        # Identity enforcement.
        # Explicit user definition requirement.
        useConfigOnly = true;
      };

      # Directory trust.
      # Universal path safety override.
      safe.directory = "*";

      # Signature verification.
      # Cryptographic SSH validation parameters.
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };

      # Change verification.
      # Automatic commit signature enforcement.
      commit.gpgSign = true;

      # Release verification.
      # Automated tag signature enforcement.
      tag.gpgSign = true;

      # Core parameters.
      # Fundamental repository execution settings.
      core = {
        editor = "nvim";
        autocrlf = "input";
      };

      # Initial branch.
      # Repository creation default identifier.
      init.defaultBranch = "main";

      # Transport protocol.
      # SSH rewrite substitution rule.
      url."git@github.com:".insteadOf = "https://github.com/";

      # Remote cleanup.
      # Stale branch reference removal.
      fetch.prune = true;

      # History alignment.
      # Downstream commit rebase policy.
      pull.rebase = true;

      # Upstream publication.
      # Remote branch push defaults.
      push = {
        # Push behavior.
        # Target reference transmission rules.
        default = "simple";
        autoSetupRemote = true;

        # Tag propagation.
        # Associated release marker upload.
        followTags = true;
      };

      # Branch integration.
      # Linear history rewrite parameters.
      rebase = {
        # Rebase automation.
        # Workspace state preservation settings.
        autoStash = true;
        autoSquash = true;

        # Reference pointers.
        # Stacked branch head adjustments.
        updateRefs = true;
      };

      # Conflict resolution.
      # Structural merge presentation format.
      merge = {
        renames = true;
        conflictStyle = "zdiff3";
      };

      # Difference engine.
      # Code comparison algorithm selection.
      diff.algorithm = "histogram";
    };
  };
}
