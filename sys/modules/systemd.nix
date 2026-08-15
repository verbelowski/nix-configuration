{ ... }: {
  # Service orchestration.
  # Background daemon lifecycle management.
  systemd = {
    # Memory management.
    # Resource exhaustion slice monitor.
    oomd = {
      enableSystemSlice = true;
      enableUserSlices = true;
    };

    # Crash dumps.
    # Process failure state log.
    coredump.enable = false;
  };
}
