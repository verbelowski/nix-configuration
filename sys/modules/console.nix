{ vars, ... }: {
  # TTY configuration.
  # Terminal appearance and input settings.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
    earlySetup = true;
  };

  # Login configuration.
  # Automatic Getty and silent boot settings.
  services.getty = {
    autologinUser = vars.user.name;
    extraArgs = [ "--nonewline" "--noissue" "--noreset" "--noclear" ];
  };
}
