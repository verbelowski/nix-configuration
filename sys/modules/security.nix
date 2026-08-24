{ ... }: {
  # System security enforcement.
  # Authentication privilege escalation policies.
  security = {
    # Privilege escalation.
    # Superuser command execution rules.
    sudo = {
      # Password prompt.
      # Escalation authentication requirement flag.
      wheelNeedsPassword = false; # TODO: Remove this option for security reasons once configuration is complete.

      # Wheel boundary.
      # Superuser access restriction switch.
      execWheelOnly = true;
    };

    # Kernel protection.
    # System execution space shield.
    protectKernelImage = true;
  };
}
