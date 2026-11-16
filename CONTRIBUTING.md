# Commenting guidelines

This is a personal configuration and I do not expect contributions, but these rules document the comment style I apply to the Nix source in this repository and the one I ask for if you send a patch anyway.

## Rules

1. **Two-part structure**: every comment consists of exactly two single-line parts, a header and a description.
2. **Header length**: a thematic title of two or three words, preferring two unless that makes it ambiguous.
3. **No verbs**: both the header and the description are noun phrases.
4. **One fact**: the description states exactly one cohesive fact that expands the header. Unrelated facts joined by conjunctions need separate comments.
5. **Enumerations**: comma-separated lists only for values that are inherently made of equivalent parts. Otherwise use one uniform noun phrase.
6. **No repetition**: no word or synonym is repeated within one comment.
7. **Cross-file consistency**: comments documenting the same key in different files share an identical header. The description adapts to the context.
8. **Precise vocabulary**: avoid vague words such as `all`, `additional`, `extra`, `various`, `other`, `some`.
9. **Abbreviations**: only universally recognized acronyms (`API`, `HTTP`). Spell out everything else (`information`, `configuration`, `directory`).
10. **US English**: use US spelling throughout (`color`, not `colour`).
11. **Punctuation**: both parts end with a period, and the description starts with a capital letter.
12. **Placement**: directly above the documented code, with no blank line in between. Inline comments are only allowed with a `NOTE`, `TODO` or `FIXME` prefix.
13. **Line length**: at most `80` characters per line.
14. **No redundancy**: do not state what the adjacent code already says, including purpose clauses ("for X") that restate visible syntax. A comment must add information beyond the syntax, such as the reason or the constraint.
15. **Value independence**: describe the option's role or category, not its current value. Descriptions of lists stay valid when entries are added or removed.
16. **Proportional length**: the description has at most twice as many words as the header.

## Examples

> [!TIP]
> **Compliant**
>
> The comment gives the reason, which the code does not show:
>
> ```nix
> # Boot permissions.
> # Random seed exposure mitigation.
> fileSystems."/boot".options = [ "umask=0077" ];
> ```

> [!WARNING]
> **Non-compliant**
>
> ```nix
> # Boot config.
> # Sets up the loader for booting.
> boot.loader.systemd-boot.enable = true;
> ```
>
> Violations:
>
> * **No verbs** (3): contains a verb phrase (`sets up`).
> * **Abbreviations** (9): uses a truncated term (`config`).
> * **No repetition** (6): repeats a word (`boot`).
> * **No redundancy** (14): restates what the option name already says.
