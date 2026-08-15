{ vars, ... }: {
  # Version control.
  # Source code revision tracking.
  programs.git = {
    # Git activation.
    # Revision tracking system switch.
    enable = true;

    # Core settings.
    # Revision tracking configuration tree.
    settings = {
      # Commit author.
      # Developer identity metadata defaults.
      user = {
        # Author identity.
        # Developer contact metadata specification.
        name = vars.capitalize vars.user.name;
        email = vars.user.email;

        # Signing key.
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

      # Upstream publishing.
      # Remote branch push defaults.
      push = {
        # Push behavior.
        # Upstream reference transmission rules.
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
        # Automated workspace state preservation.
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
      # Histogram code comparison algorithm.
      diff.algorithm = "histogram";
    };
  };
}
