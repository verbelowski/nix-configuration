# nix-configuration

Personal NixOS configuration with Hyprland and Caelestia shell dotfiles.

## Project Structure

```bash
├── lib
│   ├── import-modules.nix
│   │   ├── # Evaluation logic.
│   │   ├── # Directory path definitions.
│   ├── shared-variables.nix
│   │   ├── # Global constants.
│   │   ├── # Shared system settings.
├── sys
│   ├── modules
│   │   ├── boot.nix
│   │   │   ├── # Startup sequence.
│   │   │   ├── # Core kernel settings.
│   │   ├── console.nix
│   │   │   ├── # Terminal appearance.
│   │   │   ├── # Keymap layout definitions.
│   │   ├── i18n.nix
│   │   │   ├── # Locale settings.
│   │   │   ├── # Timezone region definitions.
│   │   ├── networking.nix
│   │   │   ├── # Interface configuration.
│   │   │   ├── # Firewall security policy.
│   │   ├── nix.nix
│   │   │   ├── # Package manager.
│   │   │   ├── # Garbage collection policy.
│   │   ├── security.nix
│   │   │   ├── # Privilege management.
│   │   │   ├── # Administrative access policy.
│   │   ├── systemd.nix
│   │   │   ├── # Service lifecycle management.
│   │   │   ├── # Resource and crash policy.
│   │   ├── users.nix
│   │   │   ├── # Account configuration.
│   │   │   ├── # Group membership definitions.
│   ├── configuration.nix
│   │   ├── # Host integration.
│   │   ├── # Base platform configuration.
│   ├── hardware-configuration.nix
│   │   ├── # Hardware layout.
│   │   ├── # Filesystem storage definitions.
├── usr
│   ├── modules
│   │   ├── git.nix
│   │   │   ├── # Version control.
│   │   │   ├── # User identity settings.
│   │   ├── neovim.nix
│   │   │   ├── # Editor options.
│   │   │   ├── # Plugin architecture definitions.
│   │   ├── ssh.nix
│   │   │   ├── # Remote access.
│   │   │   ├── # Security key policy.
│   │   ├── zsh.nix
│   │   │   ├── # Shell customization.
│   │   │   ├── # Theme style options.
│   ├── home.nix
│   │   ├── # Profile integration.
│   │   ├── # Home environment configuration.
├── flake.lock
│   ├── # Version lock.
│   ├── # Immutable dependency hashes.
├── flake.nix
│   ├── # Dependency map.
│   ├── # System structure definitions.
├── LICENSE.md
│   ├── # Legal basis.
│   ├── # Usage permission definitions.
├── README.md
│   ├── # Project overview.
│   ├── # Repository structure documentation.
```

## Hardware Interaction

### System Functional Keys

* **F1**: Access BIOS/UEFI firmware interface.
* **F5**: Display hardware asset information.
* **F10**: Execute system diagnostic utility.
* **F12**: Trigger boot device selection menu.

### Boot Menu Selection

* **LTS Version**: Prioritize system stability and reduced error probability.
* **Latest Kernel**: Prioritize feature availability and hardware compatibility.

## Disk Sanitization

Permanent storage erasure via block overwrite.

> **Warning:** Operation causes irreversible data loss on the designated target device. Verification of the correct identifier via `lsblk` is mandatory before execution.

```bash
dd if=/dev/zero of=/dev/sda bs=1M status=progress
```

> **Note:** Process duration depends on the storage capacity and write velocity.

## NixOS Installation

### 1. Root Access

Switch to the root user to begin the installation process.

```bash
sudo -i
```

> **Note:** Press `Ctrl+L` to clear the terminal screen.

### 2. Internet Connection

Establish a Wi-Fi connection if you are not using an Ethernet cable.

```bash
nmcli device wifi list
nmcli device wifi connect "WIFI_NAME" password "WIFI_PASSWORD"
```

> **Note:** Press `Ctrl+C` to interrupt and exit the current operation.

### 3. Disk Partitioning

Identify your drive and create the required GPT partitions.

```bash
lsblk
cfdisk /dev/sda
```

* Select a **GPT** partition table.
* Create a new partition -> `1G` -> **EFI System**
* Create a new partition -> `4G` -> **Linux swap**
* Create a new partition -> Remaining disk space -> **Linux filesystem**
* Confirm changes by selecting **Write**, then terminate with **Quit**.

### 4. Filesystem Formatting

Initialize the filesystems on the newly created partitions.

```bash
mkfs.ext4 -L nixos /dev/sda3
mkswap -L swap /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda1
```

### 5. Partition Mounting

Mount the partitions to the target installation directory and enable swap.

```bash
mount /dev/sda3 /mnt
mount --mkdir /dev/sda1 /mnt/boot/efi
swapon /dev/sda2
mount -t efivarfs efivarfs /sys/firmware/efi/efivars
```

### 6. System Configuration

Generate the initial configuration structure.

```bash
nixos-generate-config --root /mnt
vim /mnt/etc/nixos/configuration.nix
```

Update the generated `configuration.nix` with the following base settings:

```nix
{ pkgs, ... }: {
  # Imports required dependencies.
  imports = [ ./hardware-configuration.nix ];

  # Uses the systemd-boot EFI bootloader.
  boot.loader = {
    systemd-boot.enable = true;

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  # Uses the Zen kernel optimized for gaming.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Enables network management.
  networking.networkmanager.enable = true;

  # Creates a user account.
  users.users.vertennn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # Installs list of defined system packages.
  # https://search.nixos.org/
  environment.systemPackages = with pkgs; [ git ];

  # Sets version of first NixOS installation.
  system.stateVersion = "26.05";
}
```

### 7. Base Installation

Run the installer and set the password for your user account.

```bash
nixos-install
nixos-enter --root /mnt -c 'passwd vertennn'
```

### 8. System Reboot

Restart the machine to boot into your new system.

```bash
reboot
```

## Shortcut Reference

### Hyprland Environment

* **Ctrl+Q**: Initiate built-in terminal session.
* **Ctrl+M**: Switch to TTY console environment.

### Neovim Editor

* **%d**: Execute file content clearance.
* **v**: Activate graphical selection layer.
* **+y**: Copy to system clipboard.
* **:e file.nix**: Navigate to target file.
* **:p**: Paste from system clipboard.
* **i**: Activate text editing layer.

## Commenting Guidelines

Technical documentation within the source code must adhere to the following restrictions to maintain high quality and structural clarity:

1. **Two-part structure**: Every comment consists of exactly two single-line parts: a header and a description.
2. **Header limit**: A thematic title containing a minimum of two and a maximum of three words.
3. **Description style**: Noun-phrase expansion of the header meaning, strictly devoid of verbs.
4. **Vocabulary uniqueness**: Prohibition of word or synonym repetition within a single entry. Requirement for linguistic diversity.
5. **Technical nomenclature**: Strict assignment of terms to specific functions:
  * `settings`: specific configuration values (e.g., *boolean*, *nix parameters*).
  * `options`: available variants, parameters, or sets of configuration values.
  * `policy`: rules, restrictions, or operational guidelines.
  * `definitions`: declarations, mappings, or structures defining elements.
  * `configuration`: larger structures, whole module blocks, or groups of related settings.
6. **Enumeration format**: Comma-separated lists permitted only for values inherently composed of multiple equivalent parts. Otherwise, a uniform noun phrase is required.
7. **Linguistic precision**: Elimination of generic or vague terms (e.g., *all*, *additional*, *extra*, *various*, *other*, *some*).
8. **Punctuation and typography**: Strict punctuation enforcement. Both the header and the description must end with a period. The description must begin with a capital letter.
9. **Comment placement**: Strict vertical positioning directly above the documented code block without blank lines. Inline comments are prohibited unless explicitly prefixed with `NOTE`, `TODO`, or `FIXME`.
10. **Line length boundaries**: Hard character limit per line (e.g., *80*, *100*, or *120* characters) to prevent IDE text wrapping and ensure the single-line constraint is practical.
11. **Acronyms and abbreviations**: Allowance strictly for universally recognized technical acronyms (e.g., *API*, *HTTP*). Prohibition of truncated or colloquial terms (e.g., *info*, *config*, *dir* must be expanded to *information*, *configuration*, *directory*).
12. **Language standard**: Mandatory use of standard US English to eliminate spelling variations (e.g., *color* vs *colour*) and ensure repository-wide consistency.

## Technical Resources

* Nix: [File Reference](https://nix.dev/manual/nix/2.34/command-ref/conf-file)
* NixOS: [Options Search](https://search.nixos.org/options?channel=26.05) | [Manual](https://nixos.org/manual/nixos/stable)
* Home Manager: [NixOS Settings](https://home-manager.dev/manual/26.05/nixos-options.xhtml)
* Git: [Configuration Variables](https://git-scm.com/docs/git-config)
* Neovim: [User Preferences](https://neovim.io/doc/user/options)

## Attribution Notice

The technical implementation, system architecture, and source code of this configuration are entirely human-made. However, the standardized, highly structured code comments were generated with the assistance of Claude to ensure strict and unwavering adherence to the project's rigid documentation guidelines.
