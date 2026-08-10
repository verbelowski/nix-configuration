{ ... }: {
  # Secure shell.
  # Encrypted remote access protocol.
  programs.ssh = {
    # SSH activation.
    # Client daemon configuration switch.
    enable = true;

    # Default configuration.
    # Standard system client settings switch.
    enableDefaultConfig = false;

    # Host options.
    # Connection lookup table.
    settings = {
      # Wildcard matching.
      # Global connection default rules.
      "*" = {
        # Agent forwarding.
        # Key delegation security policy.
        ForwardAgent = false;

        # Identity restriction.
        # Explicit key file selection enforcement.
        IdentitiesOnly = true;

        # Host hashing.
        # Obfuscated server registry switch.
        HashKnownHosts = false;

        # Known hosts.
        # Trusted server public key file.
        UserKnownHostsFile = "~/.ssh/known_hosts";

        # Keepalive parameters.
        # Server probe interval and retry count limits.
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;

        # Agent integration.
        # Automatic key loading policy.
        AddKeysToAgent = "yes";
      };

      # GitHub host.
      # Code platform authentication parameters.
      "github.com" = {
        # Service account.
        # Remote Git platform login name.
        User = "git";

        # Authentication key.
        # Private SSH key file path.
        IdentityFile = "~/.ssh/id_ed25519_auth";
      };
    };
  };
}
