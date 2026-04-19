{ ... }: {
  programs.ssh = {
    # Enable flag.
    # SSH client activation state.
    enable = true;

    # Default configuration.
    # System SSH baseline override.
    enableDefaultConfig = false;

    # Host rules.
    # SSH match block definitions.
    matchBlocks = {
      "*" = {
        # Global defaults.
        # Connection behavior baseline.
        identitiesOnly = true;
        forwardAgent = false;

        # Keep-alive.
        # Connection stability settings.
        serverAliveInterval = 60;
        serverAliveCountMax = 3;

        # Agent usage.
        # SSH key agent integration.
        addKeysToAgent = "yes";
      };

      "github.com" = {
        # Git host.
        # GitHub SSH identity mapping.
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
