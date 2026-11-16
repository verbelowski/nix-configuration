# Installation

Step-by-step installation of NixOS and this configuration on a fresh machine, which is also the reference for what `install.sh` in the repository root does.

> [!NOTE]
> **Automated installation.** `install.sh` runs every step of [Installing NixOS](#installing-nixos) except the optional disk wipe (step 4). Review its disk identifiers, then run it:
>
> ```bash
> chmod +x install.sh
> ./install.sh
> ```
>
> Follow the manual steps below if you prefer full control or need to customize something.

## Contents

* [Before you start](#before-you-start)
* [Installing NixOS](#installing-nixos)
* [Deploying the configuration](#deploying-the-configuration)
* [SSH keys](#ssh-keys)

## Before you start

Firmware shortcuts for the Lenovo IdeaCentre Gaming 5 desktop (other hardware will differ):

* **F1**: access BIOS/UEFI firmware interface.
* **F5**: display hardware asset information.
* **F10**: execute system diagnostic utility.
* **F12**: trigger boot device selection menu.

## Installing NixOS

### 1. Root access

```bash
sudo -i
```

### 2. Internet connection

Connect to Wi-Fi with the commands below, or skip them if you use Ethernet. The `--ask` flag prompts for the password so it does not end up in the shell history:

```bash
nmcli device wifi list
nmcli --ask device wifi connect "WIFI_NAME"
```

Verify connectivity:

```bash
ip a
ping nixos.org
```

### 3. Select the target disk

Device names such as `/dev/sda` can change between boots, especially with USB drives attached. Identify the disk by its stable ID instead:

```bash
lsblk -o NAME,SIZE,MODEL,SERIAL
ls -l /dev/disk/by-id/
DISK=/dev/disk/by-id/<your-disk-id>
```

Use the whole-disk entry (without `-partN`). The `DISK` variable is reused in later steps and only lives in the current shell. Define it again in a new shell.

> [!CAUTION]
> Everything below is destructive. Double-check that `"$DISK"` points to the intended drive (`readlink -f "$DISK"`, then compare with `lsblk`).

### 4. Wipe the disk (optional)

Skip this step for a drive that does not need wiping.

**SSD, quick wipe.** `blkdiscard` issues TRIM for the whole device. It is fast, but it is not a secure erase and does not guarantee that data is unrecoverable:

```bash
blkdiscard -v "$DISK"
```

**NVMe, secure erase.** `nvme-cli` may not be preinstalled on the installer image:

```bash
nix-shell -p nvme-cli --run "nvme format $DISK --ses=1"
```

**SATA SSD, secure erase.** Uses ATA Secure Erase. The drive must not be in the *frozen* state, and this usually does not work through USB adapters:

```bash
hdparm --user-master u --security-set-pass p "$DISK"
hdparm --user-master u --security-erase p "$DISK"
```

**HDD.** Overwrite with zeros (duration depends on the capacity):

```bash
dd if=/dev/zero of="$DISK" bs=1M status=progress
```

### 5. Partition the disk

```bash
cfdisk "$DISK"
```

* Select a **GPT** partition table.
* Create a new partition → `1G` → **EFI System**
* Create a new partition → `4G` → **Linux swap**
* Create a new partition → remaining space → **Linux filesystem**
* Select **Write**, then **Quit**.

Make sure the partition links exist before continuing (the order must be: 1 = EFI, 2 = swap, 3 = root):

```bash
udevadm settle
ls -l "${DISK}"-part*
```

### 6. Format the partitions

```bash
mkfs.ext4 -L nixos "${DISK}-part3"
mkswap -L swap "${DISK}-part2"
mkfs.fat -F 32 -n boot "${DISK}-part1"
```

### 7. Mount the partitions

> [!NOTE]
> `umask=077` restricts the FAT32 boot partition to `root`, which prevents `systemd-boot` warnings about a world-accessible random seed file.

```bash
mount "${DISK}-part3" /mnt
mount -o umask=077 --mkdir "${DISK}-part1" /mnt/boot
swapon "${DISK}-part2"
mount -t efivarfs efivarfs /sys/firmware/efi/efivars
```

The last command can be skipped if `/sys/firmware/efi/efivars` is already mounted.

### 8. Bootstrap configuration

Generate the initial configuration and open it:

```bash
nixos-generate-config --root /mnt
vim /mnt/etc/nixos/configuration.nix
```

This configuration is only a bootstrap, and the repository replaces it in [the deployment step](#deploying-the-configuration). Keep the generated `imports` and `system.stateVersion` entries as they are. Replace everything else inside the outer braces with the following:

```nix
# Boot loader.
# Firmware entry registration.
boot.loader = {
  systemd-boot.enable = true;
  efi.canTouchEfiVariables = true;
};

# Kernel packages.
# Driver module compatibility.
boot.kernelPackages = pkgs.linuxPackages_zen;

# Network manager.
# Post-reboot connectivity.
networking.networkmanager.enable = true;

# User account.
# Administrative login.
users.users.vertennn = {
  isNormalUser = true;
  extraGroups = [ "wheel" ];
};

# System packages.
# Pre-deployment tooling.
environment.systemPackages = with pkgs; [ git ];
```

### 9. Install

`nixos-install` asks for the root password. Pass `--no-root-passwd` to skip it (the user above has `sudo` through `wheel`). Then set the user password:

```bash
nixos-install
nixos-enter --root /mnt -c 'passwd vertennn'
```

### 10. Reboot

```bash
reboot
```

Wi-Fi connections do not carry over to the installed system. After the restart, reconnect with the command from [step 2](#2-internet-connection) before deploying the configuration.

## Deploying the configuration

Clone the repository over HTTPS (SSH keys are set up in the next section):

```bash
git clone https://github.com/verbelowski/nix-configuration.git ~/nix-configuration
```

> [!IMPORTANT]
> `sys/hardware-configuration.nix` in this repository refers to filesystems by UUID, which is the NixOS default. Formatting a partition assigns it a new UUID, so the file from the repository never matches a freshly installed disk. Regenerate it before the first rebuild, then review the diff and keep any hand-written options:
>
> ```bash
> sudo nixos-generate-config --show-hardware-config > ~/nix-configuration/sys/hardware-configuration.nix
> git -C ~/nix-configuration diff sys/hardware-configuration.nix
> ```

Build and apply the configuration:

```bash
sudo nixos-rebuild switch --flake ~/nix-configuration#nixos
```

Remove the legacy imperative channels to enforce pure flake evaluation:

```bash
sudo rm -rf /root/.nix-defexpr/channels
sudo rm -rf /nix/var/nix/profiles/per-user/root/channels
```

## SSH keys

Used for Git authentication and commit signing. Generate a signing and an authentication key pair.

> [!WARNING]
> Set a passphrase when prompted. Without one the key stays unencrypted and the `-a 32` flag has no effect.

```bash
mkdir -p ~/.ssh && chmod 700 ~/.ssh
ssh-keygen -t ed25519 -a 32 -C "id_ed25519_sign" -f ~/.ssh/id_ed25519_sign
ssh-keygen -t ed25519 -a 32 -C "id_ed25519_auth" -f ~/.ssh/id_ed25519_auth
```

Register the signing key for signature verification. This builds the line from the public key you just generated (use your own e-mail address):

```bash
echo "145216301+verbelowski@users.noreply.github.com $(cut -d' ' -f1,2 ~/.ssh/id_ed25519_sign.pub)" >> ~/.ssh/allowed_signers
```

Restrict permissions:

```bash
chmod 600 ~/.ssh/id_ed25519_{auth,sign}
chmod 644 ~/.ssh/*.pub ~/.ssh/allowed_signers
```

Add both public keys to GitHub (authentication key and signing key). Afterwards the repository can be cloned over SSH:

```bash
git clone git@github.com:verbelowski/nix-configuration.git
```
