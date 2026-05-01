# Gemini Agent Protocol: Neovim Config

Welcome, AI Collaborator. This project is optimized for agentic development. To maintain consistency across sessions, you MUST follow the **Streamlined Gemini Agent Protocol**.

## 1. Context Entrypoint
- **Legacy Backlog:** Read `.agents/TODO.md` for Phase 1 tasks. Complete these first if any remain.
- **Active Tasks:** Run `gh issue list --assignee "@me"` to see your assigned tasks. If none, run `gh issue list` to see the backlog.
- **History:** Run `git log -n 5` to see what was recently completed.
- **Architecture:** Read `.agents/docs/architecture.md` to understand the code structure.

## 2. Startup Sequence
1. **Verify Environment:** Run `./init.sh` to ensure tools (`nvim`, `gh`, `git`, etc.) are healthy.
2. **Claim Task:** If picking a new issue, assign it to yourself: `gh issue edit <id> --add-assignee "@me"`.
3. **Branch Out:** Create a feature branch: `git checkout -b feature/issue-<id>`.

## 3. Execution Cycle
1. **Implement:** Write targeted, surgical code changes.
2. **Verify:** Run the `Test` command specified in the Issue description or `TODO.md`.
3. **Commit:** Use conventional commits. Always include `Fixes #<id>` in the message or PR body.

## 4. Session Shutdown
1. **Submit Work:**
   - **Legacy:** Mark as `[x]` in `.agents/TODO.md`.
   - **GitHub:** Push your branch (`git push origin HEAD`) and create a PR: `gh pr create --title "[Task Name]" --body "Fixes #<id>\n\nDetails..."`.
2. **Handoffs:** If stopping mid-task, push your branch and add a comment: `gh issue comment <id> --body "> Note: [Context for next agent]"`.

## 5. Security & Principles
- **Root Lock:** Never read/write files outside of this directory.
- **No Hardcoding:** Ensure all paths are dynamically resolved.
- **Convention First:** Adhere to existing Lua structure and `lazy.nvim` patterns.
- **PR-First:** All changes MUST be submitted via Pull Request for human review.
- **Git Identity:** Ensure `user.name` and `user.email` are configured in the environment.

## 6. The "Principal" Checklist
This project is a high-transparency substrate for the "Principal Engineer" (read [MANIFESTO.md](./MANIFESTO.md)). Before ending your session, ensure:
- **The "Why" in the Comments:** Did you document the intent behind radical architectural choices?
- **The "Escape Hatch":** Is the structure easy for a Principal to fork or override?
- **The "Telemetry of Failure":** Is the error handling highly observable? Does it explain the "Physics" of the failure?
- **The Laboratory Folder:** Are we honoring the "Living Laboratory" by keeping experimental logic isolated and visible in the Manifesto?
