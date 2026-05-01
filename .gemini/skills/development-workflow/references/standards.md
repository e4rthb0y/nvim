# Project Standards & Principles

Guidelines for maintaining high-quality, transparent development.

## Code Standards
- **Formatting**: Lua files MUST be formatted with `stylua`.
  - Native autocommand on save is active.
  - Manual verification: `stylua --config-path .stylua.toml <file>`
- **Root Lock**: Stay within the project directory.
- **No Hardcoding**: Dynamically resolve all paths.

## The "Principal" Checklist
Before finishing a task or session, verify:
- **The "Why" in Comments**: Document the intent behind radical architectural choices.
- **The "Escape Hatch"**: Ensure structures are easy for a Principal to fork or override.
- **The "Telemetry of Failure"**: Implement observable error handling that explains the "Physics" of the failure.
- **Laboratory Folder**: Keep experimental logic isolated and visible in the Manifesto.

## Core Principles
- **PR-First**: All changes require human review via PR.
- **Transparency**: Maintain a clear link between commits, PRs, and Issues.
