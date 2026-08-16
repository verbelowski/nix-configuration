{ ... }: {
  # System hardening.
  # Access restriction policy enforcement.
  security = {
    # Privilege escalation.
    # Superuser command execution rules.
    sudo = {
      # Password barrier.
      # Escalation authentication requirement flag.
      wheelNeedsPassword = false; # TODO: Remove this option for security once the configuration is stable.

      # Wheel group boundary.
      # Superuser access restriction switch.
      execWheelOnly = true;
    };

    # Kernel protection.
    # System execution space shield.
    protectKernelImage = true;
  };
}
