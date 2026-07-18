{ vars, ... }: {
  # Repository configuration.
  # Version control program options.
  programs.git = {
    # Enablement state.
    # Program activation flags.
    enable = true;

    # Global settings.
    # Version control configuration options.
    settings = {
      # Author identity.
      # Commit creator metadata fields.
      user = {
        # Personal details.
        # Commit creator name and email values.
        name = vars.capitalize vars.user.name;
        email = vars.user.email;

        # Cryptographic key.
        # SSH material for commit signature verification.
        signingKey = "~/.ssh/id_ed25519_sign.pub";

        # Scope restriction.
        # Configuration file identity value enforcement.
        useConfigOnly = true;
      };

      # Security bounds.
      # Trusted directory path definitions.
      safe.directory = "*";

      # Attestation format.
      # SSH mode and trusted signers file paths.
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };

      # Revision signing.
      # Automatic commit signature generation states.
      commit.gpgSign = true;

      # Release signing.
      # Automatic tag signature generation states.
      tag.gpgSign = true;

      # Engine options.
      # Editor and line ending configurations.
      core = {
        editor = "nvim";
        autocrlf = "input";
      };

      # Creation defaults.
      # Primary branch name definitions.
      init.defaultBranch = "main";

      # Transport substitution.
      # GitHub SSH access HTTPS rules.
      url."git@github.com:".insteadOf = "https://github.com/";

      # Fetch policy.
      # Remote branch pruning behaviors.
      fetch.prune = true;

      # Pull policy.
      # Linear history rebase behaviors.
      pull.rebase = true;

      # Push policy.
      # Remote update and authentication options.
      push = {
        # Upload mode.
        # Simple transmission strategy definitions.
        default = "simple";
        autoSetupRemote = true;

        # Release propagation.
        # Remote tag synchronization states.
        followTags = true;
      };

      # Rebase policy.
      # History rewriting rules.
      rebase = {
        # Workspace management.
        # Automatic stash and squash states.
        autoStash = true;
        autoSquash = true;

        # Pointer updates.
        # Branch reference adjustment states.
        updateRefs = true;
      };

      # Integration options.
      # Rename detection and conflict style values.
      merge = {
        renames = true;
        conflictStyle = "zdiff3";
      };

      # Comparison options.
      # Histogram diff algorithm selection.
      diff.algorithm = "histogram";
    };
  };
}
