---
name: development-workflow
description: End-to-end development lifecycle for the Neovim configuration. Use when starting a new task, managing GitHub issues, following project standards, or submitting pull requests.
---

# Development Workflow

A comprehensive guide to the agentic development lifecycle, from task discovery to submission.

## Prerequisites

- Ensure `gh`, `git`, and `stylua` are installed.
- Source the environment setup script before any operations:
    ```bash
    source ~/.agent-env.sh
    ```

## 1. Startup & Discovery
Identify your objectives and prepare your environment.
- **Environment Check**: Run `./init.sh` to verify tool health.
- **Task Discovery**: Find assigned issues or browse the backlog.
- **Reference**: See [github-ops.md](references/github-ops.md) for discovery commands.

## 2. Planning & Execution
Maintain transparency and quality during development.
- **Decompose Task**: Break down issues into atomic steps in `.agents/TODO.md` and sync to GitHub.
- **Branch & Code**: Create a feature branch and adhere to project standards.
- **Standards**: Follow the `stylua` and "Root Lock" rules.
- **Reference**: See [standards.md](references/standards.md) for code quality guidelines.

## 3. Submission & Shutdown
Validate your work and handle transitions.
- **Principal Checklist**: Perform a final self-review of architecture and telemetry.
- **Pull Request**: Submit your changes for review using conventional commits.
- **Handoffs**: If pausing, ensure the current state is documented on the issue.
- **Reference**: See [github-ops.md](references/github-ops.md) for PR and handoff commands.
