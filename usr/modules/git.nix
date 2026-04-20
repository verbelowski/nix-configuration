{ lib, vars, ... }: let
  # String helper.
  # Capitalization utility function.
  capitalize = str: with lib.strings; toUpper (substring 0 1 str) + substring 1 (stringLength str - 1) str;
in {
  # Git setup.
  # Version control configuration.
  programs.git = {
    # Enable flag.
    # Git activation state.
    enable = true;

    # Settings block.
    # Git configuration scope.
    settings = {
      # Identity configuration.
      # User identity definition.
      user = {
        # Identity fields.
        # Name and e-mail values.
        name = capitalize vars.user.name;
        email = vars.user.email;

        # Signing key.
        # SSH key for commit signing.
        signingkey = "~/.ssh/id_ed25519.pub";

        # Configuration scope.
        # Strict identity usage rule.
        useConfigOnly = true;
      };

      # Signature setup.
      # Git commit signing.
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };

      # Commit signing.
      # Signature requirement for commits.
      commit.gpgsign = true;

      # Repository init.
      # Default branch name.
      init.defaultBranch = "main";

      # Core behavior.
      # Editor and line ending handling.
      core = {
        editor = "nvim";
        autocrlf = "input";
      };

      # URL rewrite.
      # GitHub SSH transport mapping.
      url."git@github.com:".insteadOf = "https://github.com/";

      # Fetch behavior.
      # Remote branch pruning.
      fetch.prune = true;

      # Pull strategy.
      # Rebase for updates.
      pull.rebase = true;

      # Push rules.
      # Default push configuration.
      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      # Rebase rules.
      # Automatic stash and squash handling.
      rebase = {
        autoStash = true;
        autoSquash = true;
      };

      # Merge style.
      # Conflict output format.
      merge.conflictstyle = "zdiff3";

      # Safe paths.
      # Trusted repository list.
      safe.directory = "*";
    };
  };
}
