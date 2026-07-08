# Agents Instructions

These are global defaults shared across all agents on this machine.

## Response Style

- Be concise and direct by default.
- Prefer concrete outputs over long explanations.
- For reviews: list findings first by severity with file references, then summary, then open questions.

## Main rules

- **Think Before Coding.** Don't assume. Don't hide confusion. Surface tradeoffs.
  - State your assumptions explicitly. If uncertain, ask.
  - If multiple interpretations exist, present them - don't pick silently.
  - If a simpler approach exists, say so. Push back when warranted.
  - If something is unclear, stop. Name what's confusing. Ask.
- **Simplicity First.** Minimum code that solves the problem. Nothing speculative.
  - No features beyond what was asked.
  - No abstractions for single-use code.
  - No "flexibility" or "configurability" that wasn't requested.
  - No error handling for impossible scenarios.
  - If you write 200 lines and it could be 50, rewrite it.
  - Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.
- **Surgical Changes.** Touch only what you must. Clean up only your own mess. Every changed line should trace directly to the user's request.
  - Don't "improve" adjacent code, comments, or formatting.
  - Don't refactor things that aren't broken.
  - Match existing style, even if you'd do it differently.
  - If you notice unrelated dead code, mention it - don't delete it.
  - Remove imports/variables/functions that YOUR changes made unused.
  - Don't remove pre-existing dead code unless asked.
  - Don't remove any pre-existing debugging logs or comments that weren't added by you, unless asked.
- **Goal-Driven Execution.** Define success criteria. Loop until verified. Transform tasks into verifiable goals.
  - Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## Workflow Rules

- Prefer minimal diffs and incremental changes.
- Do not create permanent helper scripts for one-off requests unless the user asks.
- Respect dirty worktrees and never revert unrelated user changes.
- NEVER remove comments or debugging logs that weren't added by you, unless asked.

## Git Commits

Every commit must be:

- **Clear** — message states what changed and why, understandable without reading the diff.
- **Clean** — stage only intended files; never `git add -A`/`.`. Leave unrelated working-tree changes alone.
- **Concise** — short imperative subject (≤ ~70 chars); body only when the "why" needs it.
- **Conventional** — Conventional Commits: `type(scope): subject` (e.g. `fix(theme): ...`, `feat(api): ...`).
- **Atomic** — one logical change per commit; split unrelated work into separate commits.
- **Single author** — never add `Co-Authored-By` or any attribution trailer.

## Pull Requests

- **Before creating any PR, ask which GitHub account to use** and switch with `gh auth switch -u <user>`. Multiple accounts are configured in `gh` (e.g. `juanarrow-io`, `paolo-ar`, `paolo-nplus`); the active one is often wrong and PR creation fails with "Could not resolve to a Repository". Confirm the account, switch, then create the PR.

## Superpowers Plugin — Document Paths

- The superpowers skills default to saving documents under `docs/superpowers/<type>/` (e.g. `docs/superpowers/plans/`, `docs/superpowers/specs/`). **Override this**: skip the `superpowers/` segment and use `docs/<type>/` directly — `docs/plans/`, `docs/specs/`, `docs/diagrams/`, etc. Apply the same convention when looking up existing plans/specs.

## Safety

- Never expose secrets from local configs or environment files.
