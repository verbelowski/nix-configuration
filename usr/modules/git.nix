{ lib, vars, ... }: let
  # String transformation.
  # First character capitalization utility function.
  capitalize = str: with lib.strings; toUpper (substring 0 1 str) + substring 1 (stringLength str - 1) str;
in {
  # Git configuration.
  # Version control setup and user identity definition.
  programs.git = {
    # Feature enablement.
    # Git program activation in user environment.
    enable = true;

    # Settings scope.
    # Git configuration layer and behavior definitions.
    settings = {
      # Identity settings.
      # Commit author configuration.
      user = {
        name = capitalize vars.user.name;
        email = vars.user.email;
      };

      # Repository defaults.
      # Initial branch configuration for new repositories.
      init.defaultBranch = "main";

      # Core settings.
      # Editor selection and line ending handling rules.
      core = {
        editor = "nvim";
        autocrlf = "input";
      };

      # Credential storage.
      # Persistent authentication storage.
      credential.helper = "cache";

      # Pull behavior.
      # Rebase strategy with automatic stash handling.
      pull.rebase = true;
      rebase.autoStash = true;

      # Push behavior.
      # Remote push defaults and upstream setup.
      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      # Safe directories.
      # Allowed filesystem context for Git operations.
      safe.directory = "/home/${vars.user.name}";
    };
  };
};
