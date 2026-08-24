{ config, ... }: {
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
      # Direct GPU hardware access switch.
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
      open = true;

      # Software release channel.
      # Stable package version target.
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Kernel display control.
      # Direct DRM driver activation.
      modesetting.enable = true;

      # Energy preservation.
      # Dynamic power state policy.
      powerManagement.enable = true;

      # Media decode.
      # Hardware stream offload interface.
      videoAcceleration = true;

      # Device node retention.
      # Persistence daemon background state.
      nvidiaPersistenced = true;
    };
  };

  # Display server driver.
  # Primary graphics module selection.
  services.xserver.videoDrivers = [ "nvidia" ];

  # Performance profile.
  # Dynamic system optimization service.
  programs.gamemode = {
    # Service activation.
    # Background daemon enablement.
    enable = true; # NOTE: Switches default `powerManagement.cpuFreqGovernor` from `powersave` to `performance` during gameplay.

    # Execution parameters.
    # GameMode runtime setting block.
    settings.general = {
      # Process priority.
      # CPU scheduler override level.
      renice = 10;

      # Screen preservation.
      # Display idle timeout control.
      inhibit_screensaver = 0;

      # Bus locking.
      # Atomic instruction boundary penalty.
      disable_splitlock = 0;
    };
  };
}
