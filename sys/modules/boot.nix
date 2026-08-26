{ pkgs, ... }: {
  # Boot initialization.
  # Primary execution framework specification.
  boot = {
    # Kernel selection.
    # Core operating system drivers.
    kernelPackages = pkgs.linuxPackages_zen;

    # Kernel parameters.
    # Low-level execution flags.
    kernelParams = [
      # Screen output.
      # Textual status message suppression.
      "quiet"

      # Log verbosity.
      # System console notification threshold.
      "loglevel=3"

      # Service status.
      # Background daemon progress concealment.
      "systemd.show_status=false"
      "rd.systemd.show_status=false"

      # Device manager.
      # Hardware event log restriction.
      "rd.udev.log_level=3"
      "udev.log_priority=3"

      # Console prompt.
      # Virtual cursor motion halt.
      "vt.global_cursor_default=0"

      # Processor features.
      # Intel enclave capability deactivation.
      "nosgx"

      # Diagnostic audit.
      # Machine check fault suppression.
      "mce=nobootlog"

      # Storage diagnostics.
      # ATA DMA log suppression.
      "libata.force=1.00:nodmalog"

      # Memory allocation.
      # Core cache separation policy.
      "slab_nomerge"

      # Dynamic heap.
      # RAM wipe policy.
      "init_on_alloc=1"
      "init_on_free=1"

      # Page order.
      # System memory block permutation.
      "page_alloc.shuffle=1"

      # Stack protection.
      # Kernel call offset randomization.
      "randomize_kstack_offset=on"

      # Virtual filesystems.
      # Unused subsystem access reduction.
      "debugfs=off"
      "vsyscall=none"
    ];

    # Network schedulers.
    # Congestion management algorithm drivers.
    kernelModules = [ "tcp_bbr" "sch_cake" ];

    # Module blocklist.
    # Dynamic subsystem load prohibition.
    blacklistedKernelModules = [
      # Hardware watchdogs.
      # Motherboard safety circuit shutdown.
      "iTCO_wdt"
      "intel_oc_wdt"

      # Chassis speaker.
      # Internal audio signaller mute.
      "pcspkr"

      # Transport protocols.
      # Specialized network socket drivers.
      "dccp"
      "sctp"

      # Cluster communication.
      # Distributed node traffic restriction.
      "rds"
      "tipc"

      # Frame encapsulation.
      # High-level data link driver.
      "n-hdlc"

      # Packet radio.
      # Amateur wireless network protocols.
      "ax25"
      "netrom"
      "x25"
      "rose"

      # Legacy architectures.
      # Outdated communication stack removal.
      "decnet"
      "econet"
      "ipx"
      "appletalk"

      # Sensor networks.
      # Personal area infrastructure drivers.
      "af_802154"
      "can"
      "atm"

      # Data link.
      # Logical packet layer containment.
      "psnap"
      "p8023"
      "p8022"

      # Flash storage.
      # Embedded read-only image formats.
      "cramfs"
      "jffs2"

      # Enterprise filesystems.
      # Shared disk volume drivers.
      "freevxfs"
      "gfs2"

      # Optical media.
      # Universal disk format driver.
      "udf"

      # Apple filesystems.
      # Proprietary volume structure exclusion.
      "hfs"
      "hfsplus"

      # Archival images.
      # Compressed read-only volume module.
      "squashfs"

      # File exchange.
      # Network message block protocols.
      "cifs"
      "ksmbd"

      # Remote mounts.
      # Shared directory access drivers.
      "nfs"
      "nfsv3"
      "nfsv4"

      # Serial bus.
      # IEEE 1394 interface drivers.
      "firewire-core"
      "firewire-ohci"
      "firewire-sbp2"
      "firewire-net"

      # Video capture.
      # Obsolete multimedia hardware interface.
      "ohci1394"
      "sbp2"
      "dv1394"
      "raw1394"
      "video1394"

      # Controller ports.
      # Direct memory access bus.
      "thunderbolt"

      # Virtual displays.
      # Synthetic video capture device.
      "vivid"
    ];

    # Subsystem controls.
    # Runtime kernel configuration settings.
    kernel.sysctl = {
      # Handle limits.
      # System file descriptor threshold.
      "fs.file-max" = 1000000;

      # Notification boundaries.
      # Inotify event monitor capacity.
      "fs.inotify.max_user_watches" = 524288;
      "fs.inotify.max_user_instances" = 256;

      # Link protection.
      # Shared directory security rules.
      "fs.protected_fifos" = 2;
      "fs.protected_regular" = 2;

      # Process ceiling.
      # Maximum task identifier value.
      "kernel.pid_max" = 4194303;

      # Crash recovery.
      # Process failure log redirection.
      "kernel.core_pattern" = "|/bin/false";

      # Address privacy.
      # Kernel pointer disclosure prevention.
      "kernel.kptr_restrict" = 2;

      # Socket queue.
      # Maximum connection capacity threshold.
      "net.core.somaxconn" = 65536;

      # Device backlog.
      # Inbound packet queue ceiling.
      "net.core.netdev_max_backlog" = 250000;

      # Buffer limits.
      # Dynamic socket transfer boundaries.
      "net.core.rmem_max" = 16777216;
      "net.core.wmem_max" = 16777216;

      # Packet dispatch.
      # Default queue discipline algorithm.
      "net.core.default_qdisc" = "cake";

      # Bytecode security.
      # Compiler mitigation level.
      "net.core.bpf_jit_harden" = 2;

      # SYN backlog.
      # Half-open connection capacity threshold.
      "net.ipv4.tcp_max_syn_backlog" = 65536;

      # Port allocation.
      # Ephemeral outbound socket boundaries.
      "net.ipv4.ip_local_port_range" = "1024\t65535";

      # Connection reuse.
      # TIME-WAIT state socket reset.
      "net.ipv4.tcp_tw_reuse" = 1;

      # Termination duration.
      # Closed socket hold interval.
      "net.ipv4.tcp_fin_timeout" = 15;

      # Memory vectors.
      # Bidirectional network window buffers.
      "net.ipv4.tcp_rmem" = "4096\t87380\t16777216";
      "net.ipv4.tcp_wmem" = "4096\t65536\t16777216";

      # Bandwidth optimization.
      # Network congestion control algorithm.
      "net.ipv4.tcp_congestion_control" = "bbr";

      # Flood mitigation.
      # SYN attack defense mechanism.
      "net.ipv4.tcp_syncookies" = 1;

      # Socket teardown.
      # TIME-WAIT reset packet rejection.
      "net.ipv4.tcp_rfc1337" = 1;

      # Fast open.
      # Connection handshake latency reduction.
      "net.ipv4.tcp_fastopen" = 3;

      # Path validation.
      # Strict packet origin check.
      "net.ipv4.conf.all.rp_filter" = 1;
      "net.ipv4.conf.default.rp_filter" = 1;

      # ICMP safety.
      # Subnet echo response suppression.
      "net.ipv4.icmp_echo_ignore_broadcasts" = 1;
      "net.ipv4.icmp_ignore_bogus_error_responses" = 1;

      # Path updates.
      # Gateway route modification rejection.
      "net.ipv4.conf.all.secure_redirects" = 0;
      "net.ipv4.conf.default.secure_redirects" = 0;

      # Redirect rejection.
      # Bidirectional packet route policy.
      "net.ipv4.conf.all.accept_redirects" = 0;
      "net.ipv4.conf.default.accept_redirects" = 0;
      "net.ipv6.conf.all.accept_redirects" = 0;
      "net.ipv6.conf.default.accept_redirects" = 0;
      "net.ipv4.conf.all.send_redirects" = 0;
      "net.ipv4.conf.default.send_redirects" = 0;

      # Swap behavior.
      # RAM cache protection level.
      "vm.swappiness" = 10;

      # Line protocols.
      # TTY driver load restriction.
      "dev.tty.ldisc_autoload" = 0;
    };

    # Terminal verbosity.
    # Boot screen output threshold.
    consoleLogLevel = 0;

    # Ramdisk output.
    # Initial stage message visibility.
    initrd.verbose = false;

    # Temporary storage.
    # Boot directory cleanup policy.
    tmp.cleanOnBoot = true;

    # Subsystem state.
    # Volatile memory page swap.
    zswap.enable = true;

    # Boot loader.
    # Systemd-based UEFI entry management.
    loader = {
      # Systemd-boot manager.
      # EFI binary selection daemon.
      systemd-boot = {
        # Activation state.
        # Startup orchestrator activation switch.
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
      timeout = 3; # TODO: Set value to `0` once configuration is complete.
    };
  };
}
