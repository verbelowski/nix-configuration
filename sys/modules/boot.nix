{ pkgs, ... }: {
  # Boot configuration.
  # System boot settings.
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

    # Zswap configuration.
    # Compressed swap cache in RAM.
    zswap.enable = true; # NOTE: Swap partition is 4GB (16GB RAM).

    # Kernel settings.
    # Runtime kernel tuning via sysctl.
    kernel.sysctl = {
      # File descriptors.
      # System-wide open file descriptor limit.
      "fs.file-max" = 1000000;

      # Inotify watches.
      # Per-user inotify watch limit.
      "fs.inotify.max_user_watches" = 524288;

      # Inotify instances.
      # Per-user inotify instance limit.
      "fs.inotify.max_user_instances" = 256;

      # Process limit.
      # Maximum process identifier value.
      "kernel.pid_max" = 4194303;

      # Core dumps.
      # Disabled core dump generation.
      "kernel.core_pattern" = "|/bin/false";

      # Connection queue.
      # Maximum socket connection backlog.
      "net.core.somaxconn" = 65536;

      # Network backlog.
      # Maximum network device receive queue.
      "net.core.netdev_max_backlog" = 250000;

      # Receive buffer.
      # Maximum socket receive buffer size.
      "net.core.rmem_max" = 16777216;

      # Send buffer.
      # Maximum socket send buffer size.
      "net.core.wmem_max" = 16777216;

      # Packet scheduler.
      # CAKE queue discipline for reduced bufferbloat.
      "net.core.default_qdisc" = "cake";

      # SYN backlog.
      # Maximum TCP SYN queue length.
      "net.ipv4.tcp_max_syn_backlog" = 65536;

      # Port range.
      # Local TCP port allocation range.
      "net.ipv4.ip_local_port_range" = "1024\t65535";

      # Socket reuse.
      # TIME_WAIT socket reuse for new connections.
      "net.ipv4.tcp_tw_reuse" = 1;

      # FIN timeout.
      # TCP connection close wait duration.
      "net.ipv4.tcp_fin_timeout" = 15;

      # TCP receive buffer.
      # Minimum, default and maximum receive buffer sizes.
      "net.ipv4.tcp_rmem" = "4096\t87380\t16777216";

      # TCP send buffer.
      # Minimum, default and maximum send buffer sizes.
      "net.ipv4.tcp_wmem" = "4096\t65536\t16777216";

      # TCP congestion control.
      # BBR algorithm for improved throughput.
      "net.ipv4.tcp_congestion_control" = "bbr";

      # SYN cookies.
      # SYN flood attack protection.
      "net.ipv4.tcp_syncookies" = 1;

      # Reverse path filter.
      # Loose source address validation.
      "net.ipv4.conf.all.rp_filter" = 2;
      "net.ipv4.conf.default.rp_filter" = 2;

      # ICMP broadcasts.
      # Broadcast ping request suppression.
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;

      # ICMP errors.
      # Bogus error response suppression.
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

      # Secure redirects.
      # ICMP redirect acceptance from gateways only.
      "net.ipv4.conf.all.secure_redirects" = 1;
      "net.ipv4.conf.default.secure_redirects" = 1;

      # Swap usage.
      # Reduced swap aggressiveness.
      "vm.swappiness" = 10;
    };

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
      timeout = 3; # TODO: Set to "0" when configuration is stable.
    };
  };
}
