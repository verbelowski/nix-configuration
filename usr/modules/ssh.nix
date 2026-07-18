{ ... }: {
  # Transport configuration.
  # Secure shell program options.
  programs.ssh = {
    # Enablement state.
    # Program activation flags.
    enable = true;

    # Fallback override.
    # Legacy SSH configuration generation states.
    enableDefaultConfig = false;

    # Target definitions.
    # Per-host connection options.
    settings = {
      "*" = {
        # Credential proxy.
        # SSH agent forwarding disabled states.
        ForwardAgent = false;

        # Material restriction.
        # Explicit identity file strict enforcement.
        IdentitiesOnly = true;

        # Fingerprint hashing.
        # Unobfuscated host entry storage states.
        HashKnownHosts = false;

        # Fingerprint path.
        # Known hosts file location definitions.
        UserKnownHostsFile = "~/.ssh/known_hosts";

        # Connection policy.
        # Server reachability check intervals and failure tolerance.
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;

        # Daemon integration.
        # Automatic key addition to agent states.
        AddKeysToAgent = "yes";
      };

      "github.com" = {
        # Remote account.
        # Git operations profile names.
        User = "git";

        # Access material.
        # Repository authentication identity file paths.
        IdentityFile = "~/.ssh/id_ed25519_auth";
      };
    };
  };
}
