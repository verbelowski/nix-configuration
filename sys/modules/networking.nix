{ vars, ... }: {
  # Network management.
  # Interface connectivity daemon control.
  networking = {
    # Machine identifier.
    # Local network node designation.
    hostName = vars.hostname;

    # Name servers.
    # Static DNS resolver addresses.
    nameservers = [ "9.9.9.9" "149.112.112.112" "2620:fe::fe" "2620:fe::9" ];

    # NetworkManager daemon.
    # System interface state parameters.
    networkmanager = {
      # Controller state.
      # Connection management daemon status.
      enable = true;

      # Log verbosity.
      # Diagnostic message filter level.
      logLevel = "OFF";

      # Resolution backend.
      # Name service integration daemon.
      dns = "systemd-resolved";

      # Wireless interface.
      # Radio hardware operation parameters.
      wifi = {
        # Power preservation.
        # Adapter energy conservation mode.
        powersave = false;

        # Hardware identity.
        # Physical adapter address randomization.
        macAddress = "random";
      };
    };
  };

  # Domain resolution.
  # Systemd DNS lookup service.
  services.resolved = {
    # Service state.
    # Local address lookup status.
    enable = true;

    # Security parameters.
    # Encrypted transmission protocol options.
    settings.Resolve = {
      # Record validation.
      # Cryptographic zone signature verification.
      DNSSEC = "true";

      # Transport security.
      # Encrypted query tunnel enforcement.
      DNSOverTLS = "true";
    };
  };
}
