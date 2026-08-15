{ pkgs, ... }: {
  # Bootloader settings.
  # Startup sequence initialization logic.
  boot = {
    # Kernel selection.
    # Core operating system drivers.
    kernelPackages = pkgs.linuxPackages_zen;

    # Kernel parameters.
    # Boot directive string definitions.
    kernelParams = [
      # Console verbosity.
      # Silent terminal output suppression.
      "quiet"
      "loglevel=3"
      "systemd.show_status=false"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"

      # Subsystem overrides.
      # Hardware diagnostic log exclusions.
      "nosgx"
      "mce=nobootlog"
      "libata.force=1.00:nodmalog"
    ];

    # Kernel drivers.
    # Network queue discipline components.
    kernelModules = [ "tcp_bbr" "sch_cake" ];

    # Disabled modules.
    # Hardware driver initialization preventions.
    blacklistedKernelModules = [ "iTCO_wdt" "intel_oc_wdt" "pcspkr" ];

    # Runtime parameters.
    # Low-level subsystem option defaults.
    kernel.sysctl = {
      # File handles.
      # Global system descriptor limit.
      "fs.file-max" = 1000000;

      # File monitoring.
      # Inotify instance observation allocation.
      "fs.inotify.max_user_watches" = 524288;

      # Watcher instances.
      # Inotify event monitor ceiling.
      "fs.inotify.max_user_instances" = 256;

      # Process limits.
      # System task identifier ceiling.
      "kernel.pid_max" = 4194303;

      # Crash dumps.
      # Application failure log redirection.
      "kernel.core_pattern" = "|/bin/false";

      # Connection backlog.
      # Listen socket queue ceiling.
      "net.core.somaxconn" = 65536;

      # Network queue.
      # Packet input buffer limit.
      "net.core.netdev_max_backlog" = 250000;

      # Read buffer.
      # Socket receive memory ceiling.
      "net.core.rmem_max" = 16777216;

      # Write buffer.
      # Socket transmit memory ceiling.
      "net.core.wmem_max" = 16777216;

      # Queue discipline.
      # Packet scheduling algorithm preference.
      "net.core.default_qdisc" = "cake";

      # Connection requests.
      # Half-open socket buffer ceiling.
      "net.ipv4.tcp_max_syn_backlog" = 65536;

      # Ephemeral ports.
      # Outbound network allocation range.
      "net.ipv4.ip_local_port_range" = "1024\t65535";

      # Socket recycling.
      # Time-wait connection reuse switch.
      "net.ipv4.tcp_tw_reuse" = 1;

      # Termination timeout.
      # Closed connection hold duration.
      "net.ipv4.tcp_fin_timeout" = 15;

      # TCP receive.
      # Inbound window memory vector.
      "net.ipv4.tcp_rmem" = "4096\t87380\t16777216";

      # TCP transmit.
      # Outbound window memory vector.
      "net.ipv4.tcp_wmem" = "4096\t65536\t16777216";

      # Congestion control.
      # Bandwidth delay optimization algorithm.
      "net.ipv4.tcp_congestion_control" = "bbr";

      # SYN protection.
      # Flood attack mitigation mechanism.
      "net.ipv4.tcp_syncookies" = 1;

      # Reverse path.
      # Loose mode packet filter.
      "net.ipv4.conf.all.rp_filter" = 2;
      "net.ipv4.conf.default.rp_filter" = 2;

      # ICMP broadcasts.
      # Subnet ping response suppression.
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;

      # ICMP errors.
      # Invalid response log suppression.
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

      # ICMP redirects.
      # Gateway redirection packet verification.
      "net.ipv4.conf.all.secure_redirects" = 1;
      "net.ipv4.conf.default.secure_redirects" = 1;

      # Memory swapping.
      # Page cache eviction ratio.
      "vm.swappiness" = 10;
    };

    # Console verbosity.
    # TTY log display threshold.
    consoleLogLevel = 0;

    # RAM disk.
    # Early boot message switch.
    initrd.verbose = false;

    # Temporary directory.
    # Volatile storage cleanup trigger.
    tmp.cleanOnBoot = true;

    # Compressed swap.
    # In-memory pooled cache storage.
    zswap.enable = true;

    # Bootloader specification.
    # System startup software parameters.
    loader = {
      # Boot loader.
      # Systemd-based UEFI entry management.
      systemd-boot = {
        # Loader activation.
        # UEFI boot menu switch.
        enable = true;

        # Command editor.
        # Boot parameter modification switch.
        editor = false;

        # Screen resolution.
        # Maximum framebuffer display mode.
        consoleMode = "max";

        # Generation history.
        # Retained system profile count.
        configurationLimit = 10;
      };

      # Firmware interface.
      # Non-volatile motherboard settings.
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      # Selection delay.
      # Boot menu display countdown.
      timeout = 3; # TODO: Set to "0" when configuration is stable.
    };
  };
}
