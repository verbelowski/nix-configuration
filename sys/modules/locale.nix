{ ... }: {
  # System timezone.
  # Local time zone definition.
  time.timeZone = "Europe/Warsaw";

  # Locale configuration.
  # Language and region settings.
  i18n = {
    # Default locale.
    # System-wide language definition.
    defaultLocale = "en_US.UTF-8";

    # Extra locales.
    # Additional regional format settings.
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
}
