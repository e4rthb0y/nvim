# GitHub & Git Operations

Technical commands for managing the development lifecycle.

## Task Discovery
- **List Assigned**: `gh issue list --assignee "@me"`
- **List Backlog**: `gh issue list`
- **View Details**: `gh issue view <id>`

## Task Lifecycle
- **Claim Task**: `gh issue edit <id> --add-assignee "@me"`
- **Start Progress**: `gh issue comment <id> --body "Starting work on this task. Follow progress in PR [link]."`
- **Atomic Breakdown**: Comment on the issue: `gh issue comment <id> --body "### Atomic Task Breakdown\n- [ ] Task 1..."`

## Development
- **Branching**: `git checkout -b feature/issue-<id>`
- **Committing**: Use conventional commits (e.g., `feat: ...`, `fix: ...`). Include `Fixes #<id>` in the PR body.
- **Pushing**: `git push origin HEAD`

## Submission
- **Create PR**:
  ```bash
  gh pr create --title "Fix: [Task Name]" --body "Fixes #<id>\n\n### Changes\n- [ ] ..." --draft
  ```
- **Handoffs**: `gh issue comment <id> --body "> Note: [Context]\n\n### Current Progress\n- [x] Task 1..."`
