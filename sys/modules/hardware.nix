{ pkgs, ... }: {
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
      # Activation state.
      # Direct GPU access switch.
      enable = true;

      # Legacy architecture.
      # 32-bit user library integration.
      enable32Bit = true;

      # Video acceleration.
      # Hardware decoding driver package.
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    };

    # Dedicated graphics card.
    # Proprietary driver configuration.
    nvidia = {
      # Kernel module type.
      # Driver architecture variant selection.
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
      # Activation state.
      # Display server session switch.
      enable = true;

      # Execution wrapper.
      # Wayland session manager integration.
      withUWSM = true;
    };

    # Performance profile.
    # Dynamic system optimization service.
    gamemode = {
      # Activation state.
      # Background daemon switch.
      enable = true; # NOTE: `powerManagement.cpuFreqGovernor` switches from `powersave` to `performance` during gameplay.

      # Option configuration.
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
