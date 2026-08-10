{ ... }: {
  # Service orchestration.
  # Background daemon lifecycle management.
  systemd = {
    # Memory management.
    # Out-of-memory daemon slice monitor.
    oomd = {
      enableSystemSlice = true;
      enableUserSlices = true;
    };

    # Crash dumps.
    # Process memory state log.
    coredump.enable = false; # NOTE: It coexists with `kernel.core_pattern`.
  };
}
