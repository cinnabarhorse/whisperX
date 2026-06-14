# Repository Instructions

## Core Principles

- Prefer the simplest, most elegant solution with the fewest LOC and the least complexity.
- Rely on the current stack when possible.
- Run E2E tests before finishing.

## Execution

- Call out sandbox or scoping blockers early, explain how to resolve them, and resolve them yourself when possible.
- Do not ask "should I do this?" unless the change is destructive, irreversible, or genuinely blocked.
- Complete all plan steps without pausing for permission between reversible steps.

## Git And Worktrees

- Work from a worktree created from `main` or `master` unless explicitly instructed otherwise.
- Create worktrees under `/tmp` using `git worktree add /tmp/[repo-name]-<task> ...`.
- Do not create worktrees outside `/tmp`.
- Never push commits, branches, tags, or direct updates to the official WhisperX repository at `github.com/m-bain/whisperX`.
- Never open or update pull requests against the official WhisperX repository unless the user explicitly asks for an upstream PR.
- For shareable work, push only to the user's fork remote and keep any PRs fork-scoped unless explicitly instructed otherwise.

## Sandbox And Cleanup

- Prefer sandbox-safe commands first. Only escalate if a required command fails in sandbox and no safe alternative exists.
- Avoid commands that commonly trigger escalation, including global installs, GUI or open commands, and writes outside the workspace or `/tmp`.
- Scoped deletion inside `/tmp` and `/private/tmp` is acceptable for disposable worktrees, caches, build artifacts, and other scratch paths.
- For disposable cleanup under `/tmp` or `/private/tmp`, use `tmp-rmrf <path>...` instead of raw `rm -rf`.
- `tmp-rmrf` lives in `~/.codex/bin` and refuses non-temp paths, path traversal outside temp, and deleting `/tmp` or `/private/tmp` themselves.
- For deleting `node_modules`, use `rm-node-modules [path ...]` instead of raw `rm -rf node_modules`.
- `rm-node-modules` lives in `~/.codex/bin`, defaults to `./node_modules`, and refuses any resolved path whose basename is not exactly `node_modules`.
- For a clean reinstall, use `npm-clean-install <dir> [npm install args ...]` instead of chaining `cd ... && rm -rf node_modules && npm install ...`.
- Allowlisted cleanup helpers only match when invoked as standalone commands, not when embedded inside compound shell commands joined with `&&` or `;`.
- Avoid broad or ambiguous destructive commands such as `rm -rf /tmp/*` or wide globs in shared temp directories.
- Avoid destructive shell patterns like `rm -rf`, `rm -f ... && cp -R ...`, or whole-directory replacement when a safer alternative exists.
- Prefer non-destructive workflows that create a fresh temp target and swap only when necessary.
- If a destructive command is still the simplest correct option, explain why before running it.
