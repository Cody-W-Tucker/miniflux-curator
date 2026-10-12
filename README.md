# Miniflux Curator

Scores unread Miniflux entries against Karakeep references and marks low-relevance entries read.

## Nix

The flake exports `packages.<system>.default` and `packages.<system>.miniflux-curator`, both providing the `miniflux-curator` command. It reads configuration from the existing environment variables used by the NixOS service.
