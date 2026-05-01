---
name: github
description: Manage development lifecycle using GitHub Issues, Projects, and Pull Requests. Use when you need to list assigned tasks, claim issues, track progress, or create pull requests for the Neovim configuration.
---

# GitHub Project & Issue Management

Manage the development lifecycle by integrating with GitHub Issues, Projects, and Pull Requests.

## Prerequisites

- Ensure `gh` CLI is installed.
- Source the environment setup script before any GitHub or Git operations:
    ```bash
    source ~/.agent-env.sh
    ```

## Workflows

### 1. Task Discovery & Selection

- **List Assigned Issues**: `gh issue list --assignee "@me"`
- **List Backlog**: `gh issue list`
- **View Issue Details**: `gh issue view <id>`

### 2. Task Lifecycle

- **Claim a Task**: `gh issue edit <id> --add-assignee "@me"`
- **Start Progress**: Add a comment to the issue: `gh issue comment <id> --body "Starting work on this task. Follow progress in PR [link]."`
- **Decompose Task**: Use `.agents/TODO.md` to track atomic steps locally.

### 3. Development & Submission

- **Branching**: Create a feature branch: `git checkout -b feature/issue-<id>`.
- **Committing**: Use conventional commits.
- **Pull Request**: Create a PR once ready:
    ```bash
    gh pr create --title "Fix: [Task Name]" --body "Fixes #<id>\n\n### Changes\n- [ ] ..." --draft
    ```
- **Handoffs**: If stopping mid-task, push the branch and comment on the issue with the current state of `.agents/TODO.md`.

## Security & Best Practices

- **Root Lock**: Stay within the `nvim/` directory for code changes.
- **Token Protection**: Never print `GITHUB_TOKEN` or `GH_TOKEN`.
- **Identity Consistency**: Verify identity with `git config user.name` after sourcing the env script.
