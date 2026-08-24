# nix-configuration

Personal NixOS configuration with Hyprland and Caelestia shell dotfiles.

> [!WARNING]
> **Notice & Disclaimer**
> * **Scope**: Represents personal reference notes and custom system dotfiles, not an installation guide.
> * **Usage**: Permitted for educational reference and inspection.
> * **Liability**: Execution occurs strictly at your own risk. No liability is assumed for system instability, misconfiguration, or data loss.

## Project Structure

```bash
├── lib
│   ├── import-modules.nix
│   │   ├── # Module importer.
│   │   ├── # Automatic Nix file evaluator.
│   ├── shared-variables.nix
│   │   ├── # Global variables.
│   │   ├── # Common system expression values.
├── sys
│   ├── modules
│   │   ├── boot.nix
│   │   │   ├── # Boot initialization.
│   │   │   ├── # Primary execution framework specification.
│   │   ├── console.nix
│   │   │   ├── # TTY console.
│   │   │   ├── # Virtual screen layout options.
│   │   ├── hardware.nix
│   │   │   ├── # Hardware management.
│   │   │   ├── # Physical component firmware configuration.
│   │   ├── i18n.nix
│   │   │   ├── # Localization preferences.
│   │   │   ├── # Regional language encoding rules.
│   │   ├── networking.nix
│   │   │   ├── # Network management.
│   │   │   ├── # Interface connectivity daemon control.
│   │   ├── nix.nix
│   │   │   ├── # Package manager.
│   │   │   ├── # Nix engine subsystem configuration.
│   │   ├── security.nix
│   │   │   ├── # System security enforcement.
│   │   │   ├── # Authentication privilege escalation policies.
│   │   ├── systemd.nix
│   │   │   ├── # Service orchestration.
│   │   │   ├── # Background daemon lifecycle management.
│   │   ├── users.nix
│   │   │   ├── # Account records.
│   │   │   ├── # User profile definitions.
│   ├── configuration.nix
│   │   ├── # External modules.
│   │   ├── # Hardware structural component declarations.
│   ├── hardware-configuration.nix
│   │   ├── # Storage mounts.
│   │   ├── # Physical disk filesystem specifications.
├── usr
│   ├── modules
│   │   ├── git.nix
│   │   │   ├── # Version control.
│   │   │   ├── # Source code revision history.
│   │   ├── neovim.nix
│   │   │   ├── # Text editor.
│   │   │   ├── # Terminal-based source code interface.
│   │   ├── ssh.nix
│   │   │   ├── # Secure shell.
│   │   │   ├── # Encrypted remote access protocol.
│   │   ├── zsh.nix
│   │   │   ├── # Command interpreter.
│   │   │   ├── # Interactive terminal session customization.
│   ├── home.nix
│   │   ├── # External modules.
│   │   ├── # User space component declarations.
├── flake.lock
│   ├── # Dependency lockfile.
│   ├── # Exact input revision pins.
├── flake.nix
│   ├── # Flake entrypoint.
│   ├── # Complete project input schema.
├── LICENSE
│   ├── # Software license.
│   ├── # Legal distribution rights terms.
├── README.md
│   ├── # Project documentation.
│   ├── # Repository instruction manual.
```

## Firmware Shortcuts

> [!NOTE]
> These key bindings are specific to a Lenovo IdeaCentre Gaming 5 desktop and may differ on other hardware.
>
> * **CPU**: Intel Core i5-10400F (6 cores, 12 threads, 2.90–4.30 GHz, 12 MB cache)
> * **Chipset**: Intel B560
> * **RAM**: 16 GB DDR4 (3200 MHz)
> * **GPU**: NVIDIA GeForce RTX 3060 (12 GB GDDR6)
> * **Storage**: 512 GB NVMe SSD, 120 GB SATA SSD, 1 TB USB SSD, 2 TB USB HDD
> * **Network**: Wi-Fi 5 (802.11 a/b/g/n/ac), 10/100/1000 Mbps LAN
> * **PSU**: 380 W

* **F1**: Access BIOS/UEFI firmware interface.
* **F5**: Display hardware asset information.
* **F10**: Execute system diagnostic utility.
* **F12**: Trigger boot device selection menu.

## Disk Sanitization

Permanent storage erasure via block overwrite.

> [!CAUTION]
> This operation causes irreversible data loss on the designated target device. Verification of the correct identifier is mandatory before execution.

> [!IMPORTANT]
> Replace `/dev/nvme0n1` with the target block device identifier. Process duration depends on the storage capacity and write velocity.

```bash
lsblk
dd if=/dev/zero of=/dev/nvme0n1 bs=1M status=progress
```

## NixOS Installation

### 1. Root Access

Switch to the root user to begin the installation process.

```bash
sudo -i
```

> [!TIP]
> Press `Ctrl+L` to clear the terminal screen.

### 2. Internet Connection

Establish a Wi-Fi connection if you are not using an Ethernet cable.

```bash
nmcli device wifi list
nmcli device wifi connect "WIFI_NAME" password "WIFI_PASSWORD"
```

Verify IP allocation and check network connectivity.

```bash
ip a
ping nixos.org
```

> [!TIP]
> Press `Ctrl+C` to interrupt and exit the current operation.

### 3. Disk Partitioning

Identify your drive and create the required GPT partitions.

```bash
lsblk
cfdisk /dev/nvme0n1
```

* Select a **GPT** partition table.
* Create a new partition → `1G` → **EFI System**
* Create a new partition → `4G` → **Linux swap**
* Create a new partition → Remaining disk space → **Linux filesystem**
* Confirm changes by selecting **Write**, then terminate with **Quit**.

### 4. Partition Formatting

Initialize the filesystems on the newly created partitions.

```bash
mkfs.ext4 -L nixos /dev/nvme0n1p3
mkswap -L swap /dev/nvme0n1p2
mkfs.fat -F 32 -n boot /dev/nvme0n1p1
```

### 5. Partition Mounting

Mount the partitions to the target installation directory and enable swap.

> [!NOTE]
> The `umask=077` flag restricts permissions on the FAT32 boot partition to `root` (0700), preventing `systemd-boot` security warnings regarding world-accessible random seed files.

```bash
mount /dev/nvme0n1p3 /mnt
mount -o umask=077 --mkdir /dev/nvme0n1p1 /mnt/boot/efi
swapon /dev/nvme0n1p2
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
  # External modules.
  # Hardware structural component declarations.
  imports = [ ./hardware-configuration.nix ];

  # Boot loader.
  # Systemd-based UEFI entry management.
  boot.loader = {
    # Systemd-boot manager.
    # EFI binary selection daemon.
    systemd-boot.enable = true;

    # Firmware interface.
    # Non-volatile variables access.
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  # Kernel selection.
  # Core operating system drivers.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # NetworkManager daemon.
  # Network configuration controller integration.
  networking.networkmanager.enable = true;

  # Account records.
  # User profile definitions.
  users.users.vertennn = {
    # Account type.
    # Non-system interactive profile flag.
    isNormalUser = true;

    # Group access.
    # Permission elevation membership list.
    extraGroups = [ "wheel" ];
  };

  # System software.
  # Globally accessible binary packages.
  environment.systemPackages = with pkgs; [ git ];

  # State compatibility.
  # Backwards migration release baseline.
  system.stateVersion = "26.05";
}
```

### 7. Installer Execution

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

## SSH Keys

Create the target SSH directory.

```bash
mkdir -p ~/.ssh
```

Generate a signing and an authentication key pair.

> [!WARNING]
> A passphrase must be configured for key encryption. Without a passphrase, the key remains unencrypted and the `-a 32` flag has no effect.

```bash
ssh-keygen -t ed25519 -a 32 -C "id_ed25519_sign" -f ~/.ssh/id_ed25519_sign
ssh-keygen -t ed25519 -a 32 -C "id_ed25519_auth" -f ~/.ssh/id_ed25519_auth
```

Restrict access to the generated key material.

> [!IMPORTANT]
> Local Git SSH signature verification requires manual creation and population of the `~/.ssh/allowed_signers` file, whereas `~/.ssh/known_hosts` is generated automatically during SSH connections.

```bash
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_ed25519_{auth,sign}
chmod 644 ~/.ssh/*.pub ~/.ssh/known_hosts ~/.ssh/allowed_signers
```

## Configuration Deployment

> [!IMPORTANT]
> **Prerequisites**
> * **Network**: Ensure active network connectivity on the newly booted system.
> * **SSH Keys**: Complete key generation (in the section above) to enable Git authentication and commit signing.

Clone the configuration repository to the home directory.

```bash
git clone https://github.com/verbelowski/nix-configuration.git
```

Build and apply the system configuration flake.

```bash
sudo nixos-rebuild switch --flake ~/nix-configuration#nixos
```

> [!TIP]
> Once this configuration is applied, Git SSH authentication and URL rewrites take effect, enabling repository operations via SSH:
>
> ```bash
> git clone git@github.com:verbelowski/nix-configuration.git
> ```

Remove legacy imperative channels to enforce pure Flake evaluation.

```bash
sudo rm -rf /root/.nix-defexpr/channels
sudo rm -rf /nix/var/nix/profiles/per-user/root/channels
```

## Shortcut Reference

> [!NOTE]
> Bindings relevant to the machine configuration process, not an exhaustive list for either environment.

Hyprland environment key bindings.

* **Ctrl+Q**: Initiate built-in terminal session.
* **Ctrl+M**: Switch to TTY console environment.

Neovim editor key bindings.

* **:%d**: Execute file content clearance.
* **v**: Activate graphical selection layer.
* **+y**: Copy to system clipboard.
* **:e file.nix**: Navigate to target file.
* **+p**: Paste from system clipboard.
* **i**: Activate text editing layer.

## Commenting Guidelines

Technical documentation within the source code must adhere to the following restrictions to maintain high quality and structural clarity:

1. **Two-part structure**: Every comment consists of exactly two single-line parts: a header and a description.
2. **Header limit**: A thematic title containing a minimum of two and a maximum of three words, gravitating toward the minimum unless fewer words cause ambiguity.
3. **Verb prohibition**: Both the header and the description are noun phrases, strictly devoid of verbs.
4. **Description scope**: The description conveys exactly one cohesive fact that expands the header meaning. Compound or unrelated facts joined by conjunctions require separate comments.
5. **Enumeration format**: Comma-separated lists permitted only for values inherently composed of multiple equivalent parts. Otherwise, a uniform noun phrase is required.
6. **Vocabulary uniqueness**: Prohibition of word or synonym repetition within a single entry. Requirement for linguistic diversity.
7. **Cross-file consistency**: Comments documenting the same key across different files share an identical header, while the description adapts to the surrounding context.
8. **Linguistic precision**: Elimination of generic or vague terms (e.g., `all`, `additional`, `extra`, `various`, `other`, `some`).
9. **Acronyms and abbreviations**: Allowance strictly for universally recognized technical acronyms (e.g., `API`, `HTTP`). Prohibition of truncated or colloquial terms (e.g., `info`, `config`, `dir` must be expanded to `information`, `configuration`, `directory`).
10. **Language standard**: Mandatory use of standard US English to eliminate spelling variations (e.g., `color` vs `colour`) and ensure repository-wide consistency.
11. **Punctuation and typography**: Strict punctuation enforcement. Both the header and the description must end with a period. The description must begin with a capital letter.
12. **Comment placement**: Strict vertical positioning directly above the documented code block without blank lines. Inline comments are prohibited unless explicitly prefixed with `NOTE`, `TODO`, or `FIXME`.
13. **Line length boundary**: Hard character limit of `80` characters per line to prevent IDE text wrapping and ensure the single-line constraint is practical.
14. **Redundancy prohibition**: Prohibition of comment content directly inferable from adjacent code, including purpose clauses (e.g., "for X") that restate a fact already visible in the syntax. Requirement for information beyond the immediate syntax.
15. **Value-independent scope**: Description addresses the option's role or category rather than its current specific value. Lists and enumerable settings receive descriptions valid regardless of the entries present or later added.
16. **Length proportionality**: Description word count does not exceed twice the header word count.

> [!TIP]
> **Compliant Example**
>
> ```nix
> # Boot loader.
> # Systemd-based UEFI entry management.
> boot.loader.systemd-boot.enable = true;
> ```

> [!WARNING]
> **Non-Compliant Example**
>
> ```nix
> # Boot config.
> # Sets up the loader for booting.
> boot.loader.systemd-boot.enable = true;
> ```
>
> **Detected Violations:**
> * **Verb prohibition**: Contains verb phrase (`sets up`).
> * **Abbreviation prohibition**: Uses truncated term (`config` instead of `configuration`).
> * **Vocabulary uniqueness**: Repeats word within entry (`boot`).

## Reference Links

* Nix: [File Reference](https://nix.dev/manual/nix/2.34/command-ref/conf-file)
* NixOS: [Options Search](https://search.nixos.org/options?channel=26.05) | [Manual](https://nixos.org/manual/nixos/stable)
* Home Manager: [NixOS Settings](https://home-manager.dev/manual/26.05/nixos-options.xhtml)
* Git: [Configuration Variables](https://git-scm.com/docs/git-config)
* Neovim: [User Preferences](https://neovim.io/doc/user/options)
