{ ... }: {
  # System security enforcement.
  # Authentication privilege escalation policies.
  security = {
    # Privilege escalation.
    # Superuser command execution rules.
    sudo = {
      # Password barrier.
      # Escalation authentication requirement flag.
      wheelNeedsPassword = false; # TODO: Remove this option for security reasons once configuration is complete.

      # Wheel group boundary.
      # Superuser access restriction switch.
      execWheelOnly = true;
    };

    # Kernel protection.
    # System execution space shield.
    protectKernelImage = true;
  };
}
