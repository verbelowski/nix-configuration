{ pkgs, ... }: {
  # Boot configuration.
  # Kernel and bootloader settings.
  boot = {
    # Kernel package.
    # Zen desktop-optimized kernel.
    kernelPackages = pkgs.linuxPackages_zen;

    # Kernel parameters.
    # Silent boot flags.
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=false"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    # Kernel modules.
    # Additional loaded kernel modules.
    kernelModules = [ "tcp_bbr" "sch_cake" ];

    # Blacklisted modules.
    # Blocked kernel modules list.
    blacklistedKernelModules = [ "iTCO_wdt" "pcspkr" ];

    # Console log level.
    # Kernel message suppression.
    consoleLogLevel = 0;

    # Initrd verbosity.
    # Early boot message suppression.
    initrd.verbose = false;

    # Temporary files.
    # Cleanup on system start.
    tmp.cleanOnBoot = true;

    # Loader configuration.
    # Bootloader and EFI settings.
    loader = {
      # Systemd-boot options.
      # EFI boot manager settings.
      systemd-boot = {
        # Enable flag.
        # Boot manager activation state.
        enable = true;

        # Kernel editor.
        # Boot parameter modification lock.
        editor = false;

        # Console mode.
        # Maximum firmware display resolution.
        consoleMode = "max";

        # Configuration limit.
        # Maximum stored NixOS generations.
        configurationLimit = 10;
      };

      # EFI options.
      # Partition and variable settings.
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      # Boot timeout.
      # Seconds before automatic boot.
      timeout = 3; # TODO: Set to "0" when configuration is stable!
    };
  };
}
