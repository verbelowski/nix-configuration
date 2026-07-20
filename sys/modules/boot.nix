{ pkgs, ... }: {
  # Platform configuration.
  # System boot definitions.
  boot = {
    # Core kernel.
    # Zen desktop-optimized variants.
    kernelPackages = pkgs.linuxPackages_zen;

    # Core options.
    # Silent initialization command flags.
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=false"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    # Module extensions.
    # Loaded kernel hardware interfaces.
    kernelModules = [ "tcp_bbr" "sch_cake" ];

    # Blacklisted extensions.
    # Kernel module identifier sets.
    blacklistedKernelModules = [ "iTCO_wdt" "pcspkr" ];

    # Runtime settings.
    # Core tuning via system control.
    kernel.sysctl = {
      # Descriptor limit.
      # System-wide open file counts.
      "fs.file-max" = 1000000;

      # Inotify watches.
      # Per-user monitoring limits.
      "fs.inotify.max_user_watches" = 524288;

      # Inotify instances.
      # Per-user allocation limits.
      "fs.inotify.max_user_instances" = 256;

      # Process threshold.
      # Maximum PID identifier values.
      "kernel.pid_max" = 4194303;

      # Crash files.
      # Disabled core dump generation.
      "kernel.core_pattern" = "|/bin/false";

      # Pending connections.
      # Maximum socket backlog sizes.
      "net.core.somaxconn" = 65536;

      # Network ingress.
      # Maximum device receive queue capacities.
      "net.core.netdev_max_backlog" = 250000;

      # Receive memory.
      # Maximum socket buffer sizes.
      "net.core.rmem_max" = 16777216;

      # Transmit memory.
      # Maximum socket outbound buffer sizes.
      "net.core.wmem_max" = 16777216;

      # Traffic scheduler.
      # CAKE queue discipline bufferbloat reduction.
      "net.core.default_qdisc" = "cake";

      # SYN backlog.
      # Maximum TCP synchronization queue lengths.
      "net.ipv4.tcp_max_syn_backlog" = 65536;

      # Port spectrum.
      # Local TCP socket allocation ranges.
      "net.ipv4.ip_local_port_range" = "1024\t65535";

      # Socket recycling.
      # TIME_WAIT state endpoint reuse.
      "net.ipv4.tcp_tw_reuse" = 1;

      # Termination timeout.
      # TCP connection wait durations.
      "net.ipv4.tcp_fin_timeout" = 15;

      # TCP inbound.
      # Minimum, default, and maximum receive memory sizes.
      "net.ipv4.tcp_rmem" = "4096\t87380\t16777216";

      # TCP outbound.
      # Minimum, default, and maximum send memory sizes.
      "net.ipv4.tcp_wmem" = "4096\t65536\t16777216";

      # Congestion control.
      # BBR algorithm for throughput improvement.
      "net.ipv4.tcp_congestion_control" = "bbr";

      # SYN cookies.
      # TCP flood attack protection mechanisms.
      "net.ipv4.tcp_syncookies" = 1;

      # Routing filter.
      # Loose source address validation modes.
      "net.ipv4.conf.all.rp_filter" = 2;
      "net.ipv4.conf.default.rp_filter" = 2;

      # ICMP broadcasts.
      # Network ping request suppression flags.
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;

      # ICMP errors.
      # Bogus failure response suppression flags.
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

      # Secure redirects.
      # ICMP route acceptance gateway restrictions.
      "net.ipv4.conf.all.secure_redirects" = 1;
      "net.ipv4.conf.default.secure_redirects" = 1;

      # Paging aggressiveness.
      # Reduced swap utilization intensity.
      "vm.swappiness" = 10;
    };

    # Output severity.
    # Kernel message suppression levels.
    consoleLogLevel = 0;

    # Initrd verbosity.
    # Early startup message suppression flags.
    initrd.verbose = false;

    # Ephemeral storage.
    # Boot-time temporary directory cleanup.
    tmp.cleanOnBoot = true;

    # Zswap settings.
    # Compressed paging cache RAM utilization.
    zswap.enable = true; # NOTE: Swap partition is 4GB (16GB RAM).

    # Startup configuration.
    # Bootloader and EFI components.
    loader = {
      # Bootloader options.
      # EFI startup manager parameters.
      systemd-boot = {
        # Enablement state.
        # Boot manager activation flags.
        enable = true;

        # Command editor.
        # Boot parameter modification locks.
        editor = false;

        # Display mode.
        # Maximum firmware console resolutions.
        consoleMode = "max";

        # Generation limit.
        # Maximum stored NixOS environment counts.
        configurationLimit = 10;
      };

      # Firmware options.
      # EFI partition and variable values.
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      # Startup timeout.
      # Automatic pre-launch delay seconds.
      timeout = 3; # TODO: Set to "0" when configuration is stable.
    };
  };
}
