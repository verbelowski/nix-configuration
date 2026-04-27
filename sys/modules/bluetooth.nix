{ ... }: {
  hardware.bluetooth = {
    enable = true;

    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };

      Policy = {
        AutoEnable = true;
      };
    };

    powerOnBoot = false;
  };
}
