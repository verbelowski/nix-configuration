{ ... }: {
  # SSH configuration.
  # Secure shell program settings.
  programs.ssh = {
    # Enable flag.
    # Program activation state.
    enable = true;

    # Default override.
    # Legacy SSH configuration generation state.
    enableDefaultConfig = false;

    # Host matching rules.
    # Per-host connection configuration settings.
    settings = {
      "*" = {
        # Agent forwarding.
        # SSH agent forwarding disabled state.
        ForwardAgent = false;

        # Identity restriction.
        # Explicit identity file only enforcement.
        IdentitiesOnly = true;

        # Known hosts hashing.
        # Unobfuscated host entry storage state.
        HashKnownHosts = false;

        # Known hosts path.
        # Known hosts file location definition.
        UserKnownHostsFile = "~/.ssh/known_hosts";

        # Keep-alive policy.
        # Server reachability check interval and failure tolerance.
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;

        # SSH agent integration.
        # Automatic key addition to agent state.
        AddKeysToAgent = "yes";
      };

      "github.com" = {
        # Remote user.
        # Git operations account name.
        User = "git";

        # Authentication key.
        # Repository access identity file path.
        IdentityFile = "~/.ssh/id_ed25519_auth";
      };
    };
  };
}
