{ ... }: {
  # Protection configurations.
  # System security parameters.
  security = {
    # Escalation configurations.
    # Privilege management options.
    sudo = {
      # Authentication requirement.
      # Wheel group passwordless sudo state.
      wheelNeedsPassword = false;

      # Binary restriction.
      # PATH executable sudo enforcement.
      execWheelOnly = true;
    };

    # Memory protection.
    # Runtime kernel modification prevention state.
    protectKernelImage = true;
  };
}
