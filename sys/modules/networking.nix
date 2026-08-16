{ vars, ... }: {
  # Network management.
  # Interface connectivity daemon control.
  networking = {
    # Host designation.
    # Local node identification string.
    hostName = vars.hostname;

    # Name servers.
    # Static DNS resolver addresses.
    nameservers = [ "9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9" ];

    # NetworkManager daemon.
    # System interface state parameters.
    networkmanager = {
      # Daemon state.
      # Network configuration controller integration.
      enable = true;

      # Journal output.
      # Log message verbosity level.
      logLevel = "OFF";

      # Resolution backend.
      # Name service integration engine.
      dns = "systemd-resolved";

      # Wireless adapter.
      # Wi-Fi hardware operation parameters.
      wifi = {
        # Power management.
        # Radio hardware energy preservation.
        powersave = false;

        # Hardware address.
        # Physical interface identity randomization.
        macAddress = "random";
      };
    };
  };

  # Name resolution.
  # Systemd-resolved DNS daemon.
  services.resolved = {
    # Resolution service.
    # Local address lookup toggle.
    enable = true;

    # Service security.
    # Encrypted resolution protocol parameters.
    settings.Resolve = {
      # Signature validation.
      # Domain record authenticity verification.
      DNSSEC = "true";

      # Encrypted transport.
      # Query transmission security enforcement.
      DNSOverTLS = "true";
    };
  };
}
