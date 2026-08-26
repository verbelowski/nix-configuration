{ ... }: {
  # Hardware management.
  # Physical component firmware configuration.
  hardware = {
    # Processor microcode.
    # Intel errata patch enablement.
    cpu.intel.updateMicrocode = true;

    # Device drivers.
    # Redistributable vendor firmware inclusion.
    enableRedistributableFirmware = true;

    # Visual stack.
    # Render framework baseline.
    graphics = {
      # Acceleration pipeline.
      # Direct GPU access switch.
      enable = true;

      # Legacy architecture.
      # 32-bit user library integration.
      enable32Bit = true;
    };

    # Dedicated graphics card.
    # Proprietary driver configuration.
    nvidia = {
      # Kernel module type.
      # Open-source driver variant selection.
      open = true; # NOTE: `branch` defaults to `stable` if `datacenter.enable` is `false`.

      # Energy preservation.
      # Dynamic power state policy.
      powerManagement.enable = true;

      # Device node retention.
      # Persistence daemon background state.
      nvidiaPersistenced = true;
    };
  };

  # Display server driver.
  # Primary graphics module selection.
  services.xserver.videoDrivers = [ "nvidia" ];

  # System applications.
  # User environment execution suite.
  programs = {
    # Wayland compositor.
    # Dynamic tiling window environment.
    hyprland = {
      # Compositor baseline.
      # Display server session enablement.
      enable = true;

      # Execution wrapper.
      # Wayland session manager integration.
      withUWSM = true;
    };

    # Performance profile.
    # Dynamic system optimization service.
    gamemode = {
      # Service activation.
      # Background daemon enablement.
      enable = true; # NOTE: `powerManagement.cpuFreqGovernor` switches from `powersave` to `performance` during gameplay.

      # Execution parameters.
      # GameMode runtime setting block.
      settings.general = {
        # Process priority.
        # CPU scheduler override level.
        renice = 10;

        # Screen preservation.
        # Display idle timeout control.
        inhibit_screensaver = 0;

        # Bus control.
        # Atomic instruction boundary penalty.
        disable_splitlock = 0; # NOTE: `split_lock_detect` protection is not disabled during gameplay.
      };
    };
  };
}
