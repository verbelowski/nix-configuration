{ ... }: {
  # Security configuration.
  # System security settings.
  security = {
    # Sudo settings.
    # Privilege escalation configuration options.
    sudo = {
      # Password requirement.
      # Wheel group passwordless sudo state.
      wheelNeedsPassword = false;

      # Execution restriction.
      # PATH-only executable sudo enforcement.
      execWheelOnly = true;
    };

    # Kernel image protection.
    # Runtime kernel modification prevention state.
    protectKernelImage = true;
  };
}
