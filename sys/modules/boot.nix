{ pkgs, ... }: {
  # Boot initialization.
  # System startup software specification.
  boot = {
    # Kernel selection.
    # Core operating system drivers.
    kernelPackages = pkgs.linuxPackages_zen;

    # Boot launch directives.
    # Startup software command line parameters.
    kernelParams = [
      # Console verbosity.
      # Terminal screen output minimization.
      "quiet"

      # Kernel log level.
      # Console message verbosity threshold.
      "loglevel=3"

      # System initialization.
      # Service progress concealment flags.
      "systemd.show_status=false"
      "rd.systemd.show_status=false"

      # Device manager.
      # Udev event verbosity reduction.
      "rd.udev.log_level=3"
      "udev.log_priority=3"

      # Terminal cursor.
      # Console prompt indicator removal.
      "vt.global_cursor_default=0"

      # Processor features.
      # Intel capability deactivation flag.
      "nosgx"

      # Hardware diagnostics.
      # Processor fault log behavior.
      "mce=nobootlog"

      # Storage controller interfaces.
      # Serial direct memory access filter.
      "libata.force=1.00:nodmalog"

      # Memory protection.
      # Allocation cache merge deactivation.
      "slab_nomerge"

      # Memory initialization.
      # Dynamic allocation heap sanitization.
      "init_on_alloc=1"
      "init_on_free=1"

      # Page allocation.
      # Physical memory location randomization.
      "page_alloc.shuffle=1"

      # Kernel stack protection.
      # System call memory layout guard.
      "randomize_kstack_offset=on"

      # Surface reduction.
      # Unused subsystem access points.
      "debugfs=off"
      "vsyscall=none"
    ];

    # Traffic schedulers.
    # Network queue algorithm drivers.
    kernelModules = [ "tcp_bbr" "sch_cake" ];

    # Module blocklist.
    # Subsystem dynamic load prevention.
    blacklistedKernelModules = [
      # Hardware watchdogs.
      # Motherboard system safety modules.
      "iTCO_wdt"
      "intel_oc_wdt"

      # Acoustic signals.
      # Internal chassis speaker driver.
      "pcspkr"

      # Transport protocols.
      # Socket communication interface exclusion.
      "dccp"
      "sctp"

      # Cluster communications.
      # Interprocess node traffic restriction.
      "rds"
      "tipc"

      # Data link.
      # Serial frame driver interface.
      "n-hdlc"

      # Radio protocols.
      # Packet transmission layer stack.
      "ax25"
      "netrom"
      "x25"
      "rose"

      # Network stacks.
      # Legacy local communication architecture.
      "decnet"
      "econet"
      "ipx"
      "appletalk"

      # Network layers.
      # Personal area infrastructure exclusion.
      "af_802154"
      "can"
      "atm"

      # Frame encapsulation.
      # Logical link protocol containment.
      "psnap"
      "p8023"
      "p8022"

      # Flash filesystems.
      # Embedded read-only image format.
      "cramfs"
      "jffs2"

      # Storage formats.
      # Cluster disk layout deactivation.
      "freevxfs"
      "gfs2"

      # Optical media.
      # Universal disk format driver.
      "udf"

      # Macintosh volumes.
      # Apple filesystem structure exclusion.
      "hfs"
      "hfsplus"

      # Read-only volumes.
      # Archival image storage module.
      "squashfs"

      # File sharing.
      # Network protocol message block.
      "cifs"
      "ksmbd"

      # Remote mounts.
      # Shared directory access drivers.
      "nfs"
      "nfsv3"
      "nfsv4"

      # Physical interfaces.
      # High-speed serial bus drivers.
      "firewire-core"
      "firewire-ohci"
      "firewire-sbp2"
      "firewire-net"

      # Legacy architecture.
      # Obsolete video capture bus.
      "ohci1394"
      "sbp2"
      "dv1394"
      "raw1394"
      "video1394"

      # Controller ports.
      # Direct memory access interface.
      "thunderbolt"

      # Virtual media.
      # Synthetic display device driver.
      "vivid"
    ];

    # Runtime parameters.
    # Low-level kernel subsystem controls.
    kernel.sysctl = {
      # Resource handles.
      # System-wide file descriptor limit.
      "fs.file-max" = 1000000;

      # File observation allocations.
      # Inotify event threshold boundaries.
      "fs.inotify.max_user_watches" = 524288;
      "fs.inotify.max_user_instances" = 256;

      # Filesystem links.
      # World-writable directory attack prevention.
      "fs.protected_fifos" = 2;
      "fs.protected_regular" = 2;

      # Process limits.
      # System task identifier ceiling.
      "kernel.pid_max" = 4194303;

      # Crash dumps.
      # Process failure log redirection.
      "kernel.core_pattern" = "|/bin/false";

      # Kernel pointers.
      # Address disclosure prevention.
      "kernel.kptr_restrict" = 2;

      # Connection backlog.
      # Maximum socket queue capacity.
      "net.core.somaxconn" = 65536;

      # Network queue.
      # Packet input buffer limit.
      "net.core.netdev_max_backlog" = 250000;

      # Socket buffer memory.
      # Dynamic transfer direction thresholds.
      "net.core.rmem_max" = 16777216;
      "net.core.wmem_max" = 16777216;

      # Queue discipline.
      # Packet schedule algorithm default.
      "net.core.default_qdisc" = "cake";

      # JIT compiler.
      # Bytecode security safeguard.
      "net.core.bpf_jit_harden" = 2;

      # Handshake requests.
      # Half-open TCP socket queue.
      "net.ipv4.tcp_max_syn_backlog" = 65536;

      # Ephemeral ports.
      # Outbound socket allocation range.
      "net.ipv4.ip_local_port_range" = "1024\t65535";

      # Socket reuse.
      # Time-wait state connection reset.
      "net.ipv4.tcp_tw_reuse" = 1;

      # Termination delay.
      # Closed socket hold duration.
      "net.ipv4.tcp_fin_timeout" = 15;

      # TCP window buffers.
      # Bidirectional traffic memory vectors.
      "net.ipv4.tcp_rmem" = "4096\t87380\t16777216";
      "net.ipv4.tcp_wmem" = "4096\t65536\t16777216";

      # Congestion control.
      # Network bandwidth optimization algorithm.
      "net.ipv4.tcp_congestion_control" = "bbr";

      # SYN protection.
      # Flood attack mitigation mechanism.
      "net.ipv4.tcp_syncookies" = 1;

      # Connection termination.
      # Time-wait tear-down protection.
      "net.ipv4.tcp_rfc1337" = 1;

      # Connection establishment.
      # Handshake latency reduction.
      "net.ipv4.tcp_fastopen" = 3;

      # Reverse path.
      # Strict packet origin filter.
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;

      # ICMP safety policies.
      # Subnet echo response suppression.
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

      # Route notices.
      # Gateway path modification rejection.
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;

      # ICMP redirects.
      # Bidirectional packet rejection policy.
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;

      # Memory swap.
      # Page eviction preference ratio.
      "vm.swappiness" = 10;

      # TTY disciplines.
      # Line protocol auto-load restriction.
      "dev.tty.ldisc_autoload" = 0;
    };

    # Console verbosity.
    # Terminal output minimization.
    consoleLogLevel = 0;

    # Early verbosity.
    # Initial RAM disk output.
    initrd.verbose = false;

    # Storage cleanup.
    # Automated temporary directory purge.
    tmp.cleanOnBoot = true;

    # Memory compression.
    # In-RAM page cache swap.
    zswap.enable = true; # NOTE: 4GB swap is sufficient for 16GB RAM without hibernation.

    # Boot loader.
    # Systemd-based UEFI entry management.
    loader = {
      # Systemd-boot manager.
      # EFI binary selection daemon.
      systemd-boot = {
        # Feature state.
        # Startup manager activation switch.
        enable = true;

        # Parameter editor.
        # Interactive kernel argument modification.
        editor = false;

        # Display mode.
        # Firmware console resolution rule.
        consoleMode = "auto";

        # Entry retention.
        # Maximum menu generation limit.
        configurationLimit = 10;
      };

      # Firmware interface.
      # Non-volatile variables access.
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      # Menu delay.
      # Startup selection countdown duration.
      timeout = 3; # TODO: Set value to "0" once configuration is complete.
    };
  };
}
