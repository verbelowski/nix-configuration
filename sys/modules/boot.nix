{ pkgs, ... }: {
  # Bootloader settings.
  # Startup sequence initialization logic.
  boot = {
    # Kernel selection.
    # Core operating system drivers.
    kernelPackages = pkgs.linuxPackages_zen;

    # Kernel parameters.
    # Silent boot console argument array.
    kernelParams = [
      "quiet"
      "loglevel=3"
      "systemd.show_status=false"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];

    # Kernel drivers.
    # Network queue discipline components.
    kernelModules = [ "tcp_bbr" "sch_cake" ];

    # Disabled modules.
    # Watchdog and speaker driver exclusions.
    blacklistedKernelModules = [ "iTCO_wdt" "pcspkr" ];

    # Runtime parameters.
    # Low-level kernel subsystem options.
    kernel.sysctl = {
      # File handles.
      # Maximum system-wide file descriptor limit.
      "fs.file-max" = 1000000;

      # File monitoring.
      # Inotify instance watch allocation limit.
      "fs.inotify.max_user_watches" = 524288;

      # Watcher instances.
      # Maximum user inotify queue ceiling.
      "fs.inotify.max_user_instances" = 256;

      # Process limits.
      # System process identifier ceiling.
      "kernel.pid_max" = 4194303;

      # Crash dumps.
      # Process failure log redirection.
      "kernel.core_pattern" = "|/bin/false";

      # Connection backlog.
      # Maximum listen socket queue size.
      "net.core.somaxconn" = 65536;

      # Network queue.
      # Packet input buffer limit.
      "net.core.netdev_max_backlog" = 250000;

      # Read buffer.
      # Socket receive memory maximum allocation.
      "net.core.rmem_max" = 16777216;

      # Write buffer.
      # Socket transmit memory maximum allocation.
      "net.core.wmem_max" = 16777216;

      # Queue discipline.
      # Packet scheduling algorithm default.
      "net.core.default_qdisc" = "cake";

      # Connection requests.
      # Half-open TCP connection queue limit.
      "net.ipv4.tcp_max_syn_backlog" = 65536;

      # Ephemeral ports.
      # Outbound socket allocation range.
      "net.ipv4.ip_local_port_range" = "1024\t65535";

      # Socket recycling.
      # Time-wait state connection reuse.
      "net.ipv4.tcp_tw_reuse" = 1;

      # Termination timeout.
      # Closed socket state hold duration.
      "net.ipv4.tcp_fin_timeout" = 15;

      # TCP receive.
      # Dynamic inbound window memory vector.
      "net.ipv4.tcp_rmem" = "4096\t87380\t16777216";

      # TCP transmit.
      # Dynamic send window memory vector.
      "net.ipv4.tcp_wmem" = "4096\t65536\t16777216";

      # Congestion control.
      # Bandwidth delay product optimization algorithm.
      "net.ipv4.tcp_congestion_control" = "bbr";

      # SYN protection.
      # Flood attack mitigation mechanism.
      "net.ipv4.tcp_syncookies" = 1;

      # Reverse path.
      # Loose mode packet source filter.
      "net.ipv4.conf.all.rp_filter" = 2;
      "net.ipv4.conf.default.rp_filter" = 2;

      # ICMP broadcasts.
      # Subnet ping response suppression.
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;

      # ICMP errors.
      # Invalid response packet log suppression.
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

      # ICMP redirects.
      # Gateway redirection packet verification.
      "net.ipv4.conf.all.secure_redirects" = 1;
      "net.ipv4.conf.default.secure_redirects" = 1;

      # Memory swapping.
      # Page cache eviction preference ratio.
      "vm.swappiness" = 10;
    };

    # Console verbosity.
    # TTY kernel log display threshold.
    consoleLogLevel = 0;

    # RAM disk.
    # Early boot initialization verbosity switch.
    initrd.verbose = false;

    # Temporary directory.
    # Volatile storage cleanup on boot.
    tmp.cleanOnBoot = true;

    # Compressed swap.
    # In-memory compressed cache pool.
    zswap.enable = true; # NOTE: Swap partition is 4GB (16GB RAM).

    # Bootloader specification.
    # System startup software parameters.
    loader = {
      # Boot loader.
      # Systemd-based UEFI entry management.
      systemd-boot = {
        # Loader activation.
        # UEFI boot menu interface switch.
        enable = true;

        # Command editor.
        # Boot entry parameter modification switch.
        editor = false;

        # Screen resolution.
        # Maximum framebuffer display mode.
        consoleMode = "max";

        # Generation history.
        # Retained system profile generation count.
        configurationLimit = 10;
      };

      # Firmware interface.
      # Non-volatile motherboard setting parameters.
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      # Selection delay.
      # Boot menu display duration countdown.
      timeout = 3; # TODO: Set to "0" when configuration is stable.
    };
  };
}
