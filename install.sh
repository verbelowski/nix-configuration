#!/usr/bin/env bash
#
# Interactive NixOS installation script.
#
# Follows steps 1-3 and 5-10 from INSTALLATION.md.
# Requires a UEFI-booted NixOS installer environment.
#
# Usage:
#
# chmod +x install.sh
# sudo ./install.sh

# Execution safety.
# Shell failure handling.
set -euo pipefail

# Terminal colors.
# Conditional ANSI formatting.
if [[ -t 1 ]]; then
  C_BLUE=$'\033[34m'
  C_YELLOW=$'\033[33m'
  C_RED=$'\033[31m'
  C_RESET=$'\033[0m'
else
  C_BLUE="" C_YELLOW="" C_RED="" C_RESET=""
fi

# Output control.
# Blank line tracking.
_SPACED_END=0

# Message output.
# Formatted console text.
_emit() {
  local color="$1"
  local label="$2"
  local message="$3"

  _SPACED_END=0
  printf '%s%s%s %s\n' "$color" "$label" "$C_RESET" "$message"
}

# Logging helpers.
# Message severity levels.
log()  { _emit "$C_BLUE" "==>" "$1"; }
warn() { _emit "$C_YELLOW" "[WARNING]" "$1"; }
die()  { _emit "$C_RED" "[ERROR]" "$1" >&2; exit 1; }

step() {
  [[ $_SPACED_END -eq 1 ]] || printf '\n'
  log "$1"
}

# Spaced execution.
# Output separation around commands.
run_spaced() {
  local status=0
  [[ $_SPACED_END -eq 1 ]] || printf '\n'
  "$@" || status=$?
  printf '\n'
  _SPACED_END=1
  return "$status"
}

# Input reading.
# Read failure detection.
safe_read() {
  _SPACED_END=0

  if ! read -r "$@"; then
    die "No input available. Run the script from an interactive terminal."
  fi
}

# User confirmation.
# Default response validation.
confirm() {
  local prompt="$1"
  local default="${2:-y}"
  local hint reply

  case "${default,,}" in
    y|yes) hint="[Y/n]" ;;
    n|no)  hint="[y/N]" ;;
    *)     die "confirm(): invalid default '$default' (expected 'y|yes' or 'n|no')." ;;
  esac

  while true; do
    safe_read -p "$prompt $hint: " reply

    reply="${reply,,}"
    [[ -z "$reply" ]] && reply="${default,,}"

    case "$reply" in
      y|yes) return 0 ;;
      n|no)  return 1 ;;
      *)     warn "Invalid response. Please answer with 'y|yes' or 'n|no'." ;;
    esac
  done
}

confirm_or_die() {
  confirm "$@" || die "Installation cancelled by the user."
}

# Partition requirements.
# Expected type comparison.
require_part_type() {
  local part="$1"
  local expected="$2"
  local actual

  actual="$(lsblk -dno PARTTYPENAME "$part")"
  [[ "$actual" == "$expected" ]] || die "Partition '$part' has type '${actual:-unknown}', but '$expected' is required."
}

# Disk discovery.
# Unmounted device search.
has_available_disk() {
  local link

  for link in /dev/disk/by-id/*; do
    [[ -b "$link" ]] || continue
    [[ "$(lsblk -dno TYPE "$link")" == "disk" ]] || continue
    [[ -z "$(lsblk -nro MOUNTPOINTS "$link")" ]] || continue

    return 0
  done

  return 1
}

# Error reporting.
# Failed command line reference.
trap 'die "Command failed at line $LINENO."' ERR

# Execution permissions.
# Superuser account verification.
if [[ $EUID -ne 0 ]]; then
  die "This script requires root privileges. Use 'sudo ./install.sh' to start it."
fi

# UEFI environment.
# Firmware startup mode.
if [[ ! -d /sys/firmware/efi ]]; then
  die "The system was booted in Legacy BIOS mode. Reboot the installer in UEFI mode and run this script again."
fi

# Installation overview.
# Disk operation warnings.
log "NixOS installation script."
log "This script partitions, formats and installs. Disk operations are IRREVERSIBLE."

confirm_or_die "Start the installation?"

# Network connection.
# Internet availability status.
step "Configuring the network connection..."

if ! nmcli -g TYPE device | grep -x wifi >/dev/null; then
  log "No Wi-Fi adapter detected. Skipping the Wi-Fi configuration..."
elif confirm "Connect to Wi-Fi? (answer 'n|no' if using Ethernet)" n; then
  run_spaced nmcli device wifi list || warn "Failed to list Wi-Fi networks. Ensure your Wi-Fi adapter is active."

  while true; do
    safe_read -p "Enter the Wi-Fi name ('q|quit' to skip): " wifi_name

    case "${wifi_name,,}" in
      q|quit)
        warn "Wi-Fi configuration skipped by the user."
        break
        ;;
      "")
        warn "The Wi-Fi name cannot be empty. Please try again."
        continue
        ;;
    esac

    if nmcli --ask device wifi connect "$wifi_name"; then
      log "Successfully connected to the Wi-Fi network '$wifi_name'."
      break
    fi

    warn "Connection attempt failed. Please check the Wi-Fi name and password."
  done
fi

run_spaced ip a
run_spaced ping -c 3 nixos.org || die "No internet connection. Check your Ethernet or Wi-Fi connection before running this script again."

# Disk selection.
# Storage device inspection.
step "Selecting the target disk..."

disk_dir="/dev/disk/by-id/"

if ! has_available_disk; then
  log "No available disks found in '$disk_dir'. Listing '/dev/disk/by-path/' instead..."
  disk_dir="/dev/disk/by-path/"
fi

run_spaced lsblk -o NAME,SIZE,MODEL,SERIAL
run_spaced ls -l "$disk_dir"

while true; do
  safe_read -p "Enter the whole-disk path (${disk_dir}<your-disk-id>): " disk

  if [[ "$disk" != /dev/disk/by-id/* && "$disk" != /dev/disk/by-path/* ]]; then
    warn "The path must start with '/dev/disk/by-id/' or '/dev/disk/by-path/'. Please try again."
    continue
  fi

  if [[ ! -b "$disk" ]]; then
    warn "Disk '$disk' does not exist. Please try again."
    continue
  fi

  if [[ "$(lsblk -dno TYPE "$disk")" != "disk" ]]; then
    warn "Disk '$disk' is not a whole device (use the entry without '-partN'). Please try again."
    continue
  fi

  if [[ -n "$(lsblk -nro MOUNTPOINTS "$disk")" ]]; then
    warn "Disk '$disk' is currently in use (it may be the installer USB drive). Please try again."
    continue
  fi

  break
done

log "Selected disk: '$disk' -> '$(readlink -f "$disk")'"
run_spaced lsblk -o NAME,SIZE,MODEL,SERIAL "$disk"

warn "The following operations are destructive: ALL DATA on '$disk' will be ERASED."
confirm_or_die "Is '$disk' the correct disk?" n

# Disk partitioning.
# Filesystem allocation scheme.
step "Partitioning '$disk'..."

cat <<'EOF'
Create the following layout in 'cfdisk':
  * Select a GPT partition table.
  * Create a new partition -> 1G -> EFI System
  * Create a new partition -> 4G -> Linux swap
  * Create a new partition -> remaining space -> Linux filesystem
  * Select 'Write', then 'Quit'.
EOF

safe_read -p "Press Enter to launch 'cfdisk'..." _
cfdisk "$disk"

# Partition check.
# Required storage format.
udevadm settle

part_efi="${disk}-part1"
part_swap="${disk}-part2"
part_root="${disk}-part3"

for part in "$part_efi" "$part_swap" "$part_root"; do
  [[ -b "$part" ]] || die "Partition '$part' does not exist. Make sure you selected 'Write' in 'cfdisk'."
done

require_part_type "$part_efi"  "EFI System"
require_part_type "$part_swap" "Linux swap"
require_part_type "$part_root" "Linux filesystem"

run_spaced ls -l "${disk}"-part*
run_spaced lsblk -o NAME,SIZE,MODEL,SERIAL "$disk"

confirm_or_die "Is the partition layout correct (1 = EFI, 2 = swap, 3 = root)?"

# Filesystem creation.
# Storage format preparation.
step "Formatting the partitions..."
confirm_or_die "Format the partitions on '$disk'?" n

mkfs.ext4 -L nixos "$part_root"
mkswap -L swap "$part_swap"
mkfs.fat -F 32 -n boot "$part_efi"

# Cleanup handler.
# Automatic mount release.
_cleanup() {
  log "Unmounting the target filesystems..."
  swapoff "$part_swap" &>/dev/null || true
  umount -R /mnt &>/dev/null || true
}

trap _cleanup EXIT

# Partition mounting.
# Target filesystem access.
step "Mounting the partitions..."

mount "$part_root" /mnt
mount -o umask=077 --mkdir "$part_efi" /mnt/boot
swapon "$part_swap"

if ! mountpoint -q /sys/firmware/efi/efivars; then
  mount -t efivarfs efivarfs /sys/firmware/efi/efivars
fi

# Bootstrap configuration.
# Generated installation file.
step "Generating the bootstrap configuration..."

nixos-generate-config --root /mnt

config_file="/mnt/etc/nixos/configuration.nix"
state_version="$(grep -m1 -oE 'system\.stateVersion[[:space:]]*=[[:space:]]*"[^"]*";' "$config_file")" \
  || die "'system.stateVersion' was not found in the generated configuration."

cat > "$config_file" <<NIXCONF
{ pkgs, ... }: {
  # Hardware imports.
  # Physical device definitions.
  imports = [ ./hardware-configuration.nix ];

  # Firmware integration.
  # UEFI boot entry registration.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Kernel configuration.
  # Linux package set selection.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Network management.
  # Automatic connection integration.
  networking.networkmanager.enable = true;

  # User account.
  # Local identity declaration.
  users.users.vertennn = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  # System packages.
  # Global program availability.
  environment.systemPackages = with pkgs; [ git ];

  # State version.
  # Initial installation release.
  ${state_version}
}
NIXCONF

log "Configuration file '$config_file' is ready."

if confirm "Review or edit '$config_file' in vim before installing?" n; then
  vim "$config_file" || warn "Editor exited with a non-zero status. Continuing anyway."
fi

# System installation.
# Configuration deployment process.
step "Installing NixOS..."

log "'nixos-install' will ask for the root password (it can be skipped with '--no-root-passwd')."
confirm_or_die "Proceed with the installation ('nixos-install')?"

nixos-install

log "Setting the password for the user 'vertennn'..."

until nixos-enter --root /mnt -c 'passwd vertennn'; do
  warn "The password was not set. Please try again."
done

# Error cleanup.
# Exit trap removal.
trap - ERR EXIT

# Installation completion.
# Final reboot instructions.
log "Installation completed successfully."
log "After rebooting, reconnect to Wi-Fi (if used) and continue with 'Deploying the configuration' in INSTALLATION.md."

# Reboot prompt.
# Manual restart option.
if confirm "Reboot the system now?"; then
  reboot
else
  log "Reboot manually ('reboot') when ready to boot into the new system."
fi
