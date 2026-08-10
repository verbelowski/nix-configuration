{ vars, ... }: {
  # Network management.
  # Interface connectivity daemon control.
  networking = {
    # Network identity.
    # Local system domain name.
    hostName = vars.hostname;

    # Static resolvers.
    # Quad9 DNS server addresses.
    nameservers = [ "9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9" ];

    # NetworkManager daemon.
    # System interface state parameters.
    networkmanager = {
      # Manager activation.
      # Interface configuration daemon switch.
      enable = true;

      # Logging verbosity.
      # System journal output level.
      logLevel = "OFF";

      # DNS backend.
      # Name resolution service integration.
      dns = "systemd-resolved";

      # Wireless interface.
      # Wi-Fi adapter hardware parameters.
      wifi = {
        # Power management.
        # Wi-Fi adapter energy reduction.
        powersave = false;

        # Hardware identity.
        # Wireless interface MAC address randomization.
        macAddress = "random";
      };
    };
  };

  # Name resolution.
  # Systemd-resolved DNS daemon.
  services.resolved = {
    # Resolved activation.
    # Local DNS caching service.
    enable = true;

    # Resolver security.
    # Encrypted DNS protocol parameters.
    settings.Resolve = {
      # DNSSEC validation.
      # Domain name signature verification.
      DNSSEC = "true";

      # Encrypted transport.
      # DNS queries over TLS protocol.
      DNSOverTLS = "true";
    };
  };
}
