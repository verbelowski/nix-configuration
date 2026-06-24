{ lib, vars, ... }: let
  # Helper functions.
  # Imported utility functions.
  helpers = import ../../lib/helper-functions.nix { inherit lib; };
in {
  # Git configuration.
  # Program entry definition.
  programs.git = {
    # Enable flag.
    # Program activation state.
    enable = true;

    # Settings block.
    # https://git-scm.com/docs/git-config
    settings = {
      # User identity.
      # Commit author metadata.
      user = {
        # Identity fields.
        # Name and e-mail values.
        name = helpers.capitalize vars.user.name;
        email = vars.user.email;

        # Signing key.
        # Key used for commit signatures.
        signingKey = "~/.ssh/id_ed25519_sign.pub";

        # Identity restriction.
        # Values (`user.name`, `user.email`) from this file only.
        useConfigOnly = true;
      };

      # Commit signature.
      # SSH format and trusted signers file.
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };

      # Commit signing.
      # Automatic signature generation for commits.
      commit.gpgSign = true;

      # Tag signing.
      # Automatic signature generation for tags.
      tag.gpgSign = true;

      # Core options.
      # Editor and line ending handling.
      core = {
        editor = "nvim";
        autocrlf = "input";
      };

      # Repository init.
      # Default branch name.
      init.defaultBranch = "main";

      # URL rewrite rule.
      # GitHub SSH access instead of HTTPS.
      url."git@github.com:".insteadOf = "https://github.com/";

      # Fetch policy.
      # Remote branch pruning.
      fetch.prune = true;

      # Pull policy.
      # Linear history during pull.
      pull.rebase = true;

      # Push policy.
      # Remote update and authentication handling.
      push = {
        # Default push mode.
        # Strategy and upstream rules.
        default = "simple";
        autoSetupRemote = true;

        # Tag propagation.
        # Remote repository tag synchronization.
        followTags = true;
      };

      # Rebase policy.
      # History rewriting process.
      rebase = {
        # Local state handling.
        # Temporary stash of local changes and commit squashing.
        autoStash = true;
        autoSquash = true;

        # Reference updates.
        # Branch state adjustment.
        updateRefs = true;
      };

      # Merge options.
      # Rename detection and conflict resolution style.
      merge = {
        renames = true;
        conflictStyle = "zdiff3";
      };

      # Diff options.
      # Comparison algorithm selection.
      diff.algorithm = "histogram";

      # Repository safety.
      # Trusted directory path.
      safe.directory = "*";
    };
  };
}
