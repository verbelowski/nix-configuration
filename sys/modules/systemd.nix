{ ... }: {
  # Service orchestration.
  # Background daemon lifecycle management.
  systemd = {
    # Resource exhaustion.
    # Out-of-memory handler settings.
    oomd = {
      enableSystemSlice = true;
      enableUserSlices = true;
    };

    # Failure diagnostics.
    # Memory dump generation toggle.
    coredump.enable = false;
  };

  # System daemons.
  # Background process control infrastructure.
  services = {
    # Message collector.
    # Central runtime event buffer.
    journald = {
      # Log persistence.
      # Transient memory placement strategy.
      storage = "volatile";

      # Journal boundaries.
      # Footprint size quota specifications.
      extraConfig = ''
        RuntimeMaxUse=500M
        RuntimeMaxFileSize=50M
      '';
    };
  };
}
