{ vars, ... }: {
  # TTY console.
  # Virtual terminal display configuration.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
    earlySetup = true;
  };

  # Terminal login.
  # Console session initialization service.
  services.getty = {
    autologinUser = vars.user.name;
    extraArgs = [ "--nonewline" "--noissue" "--noreset" "--noclear" ];
  };
}
