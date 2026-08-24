{ ... }: {
  # Localization preferences.
  # Regional language encoding rules.
  i18n = {
    # Primary language.
    # System default interface locale.
    defaultLocale = "en_US.UTF-8";

    # Regional conventions.
    # Geographic measurement unit rules.
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

  # System clock.
  # Geographic timezone designation.
  time.timeZone = "Europe/Warsaw";
}
