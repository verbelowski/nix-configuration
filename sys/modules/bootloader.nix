{ pkgs, ... }: {
  boot = {
    loader = {
      timeout = 3;

      systemd-boot = {
        enable = true;
        editor = false;

        configurationLimit = 10;

        consoleMode = "max";
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };

    boot.kernelPackages = pkgs.linuxPackages_zen;
  };
}
