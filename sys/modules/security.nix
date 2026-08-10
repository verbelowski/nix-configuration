{ ... }: {
  # System hardening.
  # Access restriction policy enforcement.
  security = {
    # Privilege escalation.
    # Superuser command execution rules.
    sudo = {
      # Password requirement.
      # Administrative escalation authentication barrier.
      wheelNeedsPassword = false; # TODO: Remove this option for security once the configuration is stable.

      # Binary restriction.
      # Group execution scope boundary.
      execWheelOnly = true;
    };

    # Kernel protection.
    # Runtime memory modification shield.
    protectKernelImage = true;
  };
}
