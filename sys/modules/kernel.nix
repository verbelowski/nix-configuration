{ ... }: {
  # Kernel settings.
  # Runtime kernel tuning.
  boot.kernel.sysctl = {
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
}
