{ ... }: {
  # SSH configuration.
  # Program entry definition.
  programs.ssh = {
    # Enable flag.
    # Program activation state.
    enable = true;

    # Default settings override.
    # Legacy SSH configuration generation.
    enableDefaultConfig = false;

    # Host matching rules.
    # Per-host connection settings.
    matchBlocks = {
      "*" = {
        # Authentication with agent control.
        # Identity restriction and key management.
        identitiesOnly = true;
        addKeysToAgent = "yes";

        # Connection keep-alive behavior.
        # Periodic reachability checks and failure tolerance.
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
      };

      "github.com" = {
        # Remote user definition.
        # Account for Git operations.
        user = "git";

        # Authentication key.
        # Identity file for repository access.
        identityFile = "~/.ssh/id_ed25519_auth";
      };
    };
  };
}
