{ ... }: {
  # SSH setup.
  # Remote access configuration.
  programs.ssh = {
    # Enablement.
    # SSH client.
    enable = true;

    # Agent.
    # Key management.
    startAgent = true;

    # Host rules.
    # Host-specific configuration.
    extraConfig = ''
      Host github.com
        User git
        IdentityFile ~/.ssh/id_ed25519
        IdentitiesOnly yes
        AddKeysToAgent yes
        ServerAliveInterval 60
        ServerAliveCountMax 3
        StrictHostKeyChecking accept-new
    '';
  };
}
