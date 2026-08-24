{ vars, ... }: {
  # TTY console.
  # Virtual screen layout options.
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
    earlySetup = true;
  };

  # Terminal login.
  # Interactive session initialization service.
  services.getty = {
    autologinUser = vars.user.name;
    extraArgs = [ "--nonewline" "--noissue" "--noreset" "--noclear" ];
  };
}
