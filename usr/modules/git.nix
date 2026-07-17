{ vars, ... }: {
  # Repository configurations.
  # Version control program options.
  programs.git = {
    # Activation flag.
    # Program enablement state.
    enable = true;

    # Global settings.
    # Version control program options.
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
      # SSH mode and trusted signers file path.
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };

      # Revision signing.
      # Automatic commit signature generation state.
      commit.gpgSign = true;

      # Release signing.
      # Automatic tag signature generation state.
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
      # GitHub SSH access over HTTPS rule.
      url."git@github.com:".insteadOf = "https://github.com/";

      # Fetch policy.
      # Remote branch pruning behavior.
      fetch.prune = true;

      # Pull policy.
      # Linear history rebase behavior.
      pull.rebase = true;

      # Push policy.
      # Remote update and authentication options.
      push = {
        # Upload mode.
        # Simple transmission strategy definitions.
        default = "simple";
        autoSetupRemote = true;

        # Release propagation.
        # Remote tag synchronization state.
        followTags = true;
      };

      # Rebase policy.
      # History rewriting rules.
      rebase = {
        # Workspace management.
        # Automatic stash and squash state.
        autoStash = true;
        autoSquash = true;

        # Pointer updates.
        # Branch reference adjustment state.
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
