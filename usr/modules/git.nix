{ vars, ... }: {
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
        name = "Vertennn";
        email = "145216301+verbelowski@users.noreply.github.com";
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
      credential.helper = "store";

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
      safe.directory = "/home/${vars.username}";
    };
  };
}
