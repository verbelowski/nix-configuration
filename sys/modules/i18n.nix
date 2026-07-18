{ ... }: {
  # Regional configuration.
  # System-wide language and area settings.
  i18n = {
    # Primary locale.
    # System-wide language definitions.
    defaultLocale = "en_US.UTF-8";

    # Specific formats.
    # Regional measurement and time settings.
    extraLocaleSettings = {
      LC_ADDRESS = "pl_PL.UTF-8";
      LC_IDENTIFICATION = "pl_PL.UTF-8";
      LC_MEASUREMENT = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
      LC_NAME = "pl_PL.UTF-8";
      LC_NUMERIC = "pl_PL.UTF-8";
      LC_PAPER = "pl_PL.UTF-8";
      LC_TELEPHONE = "pl_PL.UTF-8";
      LC_TIME = "pl_PL.UTF-8";
    };
  };

  # System timezone.
  # Local time zone definitions.
  time.timeZone = "Europe/Warsaw";
}
