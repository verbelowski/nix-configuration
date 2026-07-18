{ ... }: {
  # Protection configuration.
  # System security parameters.
  security = {
    # Escalation configuration.
    # Privilege management options.
    sudo = {
      # Authentication requirement.
      # Wheel group passwordless sudo states.
      wheelNeedsPassword = false;

      # Binary restriction.
      # Path executable sudo enforcement.
      execWheelOnly = true;
    };

    # Memory protection.
    # Runtime kernel modification prevention states.
    protectKernelImage = true;
  };
}
