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
}
