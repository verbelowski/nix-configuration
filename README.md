# nix-configuration

Personal NixOS configuration with Hyprland tiling Wayland compositor.

## Project Structure

```bash
├── lib
│   ├── import-modules.nix
│   │   ├── # Module resolution.
│   │   ├── # Path import definitions.
│   ├── shared-variables.nix
│   │   ├── # Global constants.
│   │   ├── # Common parameter sets.
├── sys
│   ├── modules
│   │   ├── boot.nix
│   │   │   ├── # Systemd-boot settings.
│   │   │   ├── # Kernel boot parameters.
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
│   │   │   ├── # Nixpkgs optimization.
│   │   │   ├── # Garbage collection policy.
│   │   ├── security.nix
│   │   │   ├── # Privilege management.
│   │   │   ├── # Sudo access rules.
│   │   ├── users.nix
│   │   │   ├── # Account definitions.
│   │   │   ├── # Group membership mappings.
│   ├── configuration.nix
│   │   ├── # Module integration.
│   │   ├── # Base configuration blocks.
│   ├── hardware-configuration.nix
│   │   ├── # Hardware mapping.
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
│   │   ├── # User integration.
│   │   ├── # Home environment configuration.
├── flake.lock
│   ├── # Lockfile generation.
│   ├── # Immutable dependency hashes.
├── flake.nix
│   ├── # Dependency management.
│   ├── # System definition structures.
├── LICENSE.md
│   ├── # Legal basis.
│   ├── # Usage permission declarations.
├── README.md
│   ├── # Project documentation.
│   ├── # Informational content blocks.
```

## Reference Documentation

* Nix: [File Reference](https://nix.dev/manual/nix/2.34/command-ref/conf-file)
* NixOS: [Options Search](https://search.nixos.org/options?channel=26.05) | [Manual](https://nixos.org/manual/nixos/stable)
* Home Manager: [NixOS Settings](https://home-manager.dev/manual/26.05/nixos-options.xhtml)
* Git: [Configuration Variables](https://git-scm.com/docs/git-config)
* Neovim: [User Preferences](https://neovim.io/doc/user/options)

## Commenting Guidelines

Technical documentation within the source code must adhere to the following restrictions to maintain high quality and structural clarity:

1. **Two-part structure**: Every comment consists of exactly two single-line parts: a header and a description.
2. **Header limit**: A thematic title containing a minimum of two and a maximum of three words.
3. **Description style**: Noun-phrase expansion of the header meaning, strictly devoid of verbs.
4. **Vocabulary uniqueness**: Prohibition of word or synonym repetition within a single entry. Requirement for linguistic diversity.
5. **Technical nomenclature**: Strict assignment of terms to specific functions:
  * `settings`: specific configuration values (e.g., boolean, nix parameters).
  * `options`: available variants, parameters, or sets of configuration values.
  * `policy`: rules, restrictions, or operational guidelines.
  * `definitions`: declarations, mappings, or structures defining elements.
  * `configuration`: larger structures, whole module blocks, or groups of related settings.
6. **Enumeration format**: Comma-separated lists permitted only for values inherently composed of multiple equivalent parts. Otherwise, a uniform noun phrase is required.
7. **Linguistic precision**: Elimination of generic or vague terms (e.g., all, additional, extra, various, other, some).
8. **Word spelling**: Avoidance of hyphens except for proper names and technical terms requiring such syntax (e.g., systemd-boot, per-user, zdiff3).

## Attribution Notice

Comments within this project have been generated with the assistance of Claude to optimize development time. Please note that the substantive content, conceptual intent, and final technical verification were entirely crafted by a human.
