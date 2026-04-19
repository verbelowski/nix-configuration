{ lib, vars, ... }: let
  # String transformation.
  # Capitalization utility.
  capitalize = str: with lib.strings; toUpper (substring 0 1 str) + substring 1 (stringLength str - 1) str;
in {
  # Git setup.
  # Version control configuration.
  programs.git = {
    # Enablement.
    # Git program.
    enable = true;

    # Settings scope.
    # Git configuration.
    settings = {
      # Identity.
      # User configuration.
      user = {
        # Fields.
        # Name and email.
        name = capitalize vars.user.name;
        email = vars.user.email;

        # Configuration scope.
        # Restricted user values.
        useConfigOnly = true;
      };

      # Init.
      # Repository defaults.
      init.defaultBranch = "main";

      # Core.
      # Editor and line handling.
      core = {
        editor = "nvim";
        autocrlf = "input";
      };

      # URL rewrite.
      # GitHub transport rules.
      url."git@github.com:".insteadOf = "https://github.com/";

      # Fetch.
      # Remote pruning.
      fetch.prune = true;

      # Pull.
      # Update strategy.
      pull.rebase = true;

      # Push.
      # Push defaults.
      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      # Rebase.
      # Rebase behavior.
      rebase = {
        autoStash = true;
        autoSquash = true;
      };

      # Merge.
      # Conflict style.
      merge.conflictstyle = "zdiff3";

      # Safe directories.
      # Repository trust list.
      safe.directory = "*";
    };
  };
}
