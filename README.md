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

## Reference Documentation

* Nix: [File Reference](https://nix.dev/manual/nix/2.34/command-ref/conf-file)
* NixOS: [Options Search](https://search.nixos.org/options?channel=26.05) | [Manual](https://nixos.org/manual/nixos/stable)
* Home Manager: [NixOS Settings](https://home-manager.dev/manual/26.05/nixos-options.xhtml)
* Git: [Configuration Variables](https://git-scm.com/docs/git-config)
* Neovim: [User Preferences](https://neovim.io/doc/user/options)

## Attribution Notice

The technical implementation, system architecture, and source code of this configuration are entirely human-made. However, the standardized, highly structured code comments were generated with the assistance of Claude to ensure strict and unwavering adherence to the project's rigid documentation guidelines.
