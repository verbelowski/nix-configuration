{ ... }: {
  # Service management.
  # Systemd lifecycle and resource configuration.
  systemd = {
    # Memory management.
    # Proactive out-of-memory handling.
    oomd = {
      enableSystemSlice = true;
      enableUserSlices = true;
    };

    # Crash preservation.
    # Disabled systemd coredump processing.
    coredump.enable = false; # NOTE: It coexists with `kernel.core_pattern`.
  };
}
