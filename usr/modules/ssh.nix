{ ... }: {
  # Transport configurations.
  # Secure shell program options.
  programs.ssh = {
    # Activation flag.
    # Program enablement state.
    enable = true;

    # Fallback override.
    # Legacy SSH configurations generation state.
    enableDefaultConfig = false;

    # Target definitions.
    # Per-host connection options.
    settings = {
      "*" = {
        # Credential proxy.
        # SSH agent forwarding disabled state.
        ForwardAgent = false;

        # Material restriction.
        # Explicit identity file strict enforcement.
        IdentitiesOnly = true;

        # Fingerprint hashing.
        # Unobfuscated host entry storage state.
        HashKnownHosts = false;

        # Fingerprint path.
        # Known hosts file location definitions.
        UserKnownHostsFile = "~/.ssh/known_hosts";

        # Connection policy.
        # Server reachability check interval and failure tolerance.
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;

        # Daemon integration.
        # Automatic key addition to agent state.
        AddKeysToAgent = "yes";
      };

      "github.com" = {
        # Remote account.
        # Git operations profile name.
        User = "git";

        # Access material.
        # Repository authentication identity file path.
        IdentityFile = "~/.ssh/id_ed25519_auth";
      };
    };
  };
}
