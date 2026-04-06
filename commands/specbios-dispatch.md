---
description: Dispatch and execute the current task from the SpecBIOS task board
argument-hint: [task-id]
allowed-tools: [Read, Edit, Write, Glob, Grep, Bash]
---

# /specbios-dispatch

Dispatch and execute the current task from the SpecBIOS task board.

## Arguments

The user invoked this command with: $ARGUMENTS

## Instructions

When invoked:

1. Check whether `.specbios.json` exists. If not, tell the user this is not a SpecBIOS project and suggest `/specbios-init`.
2. Read `.specbios.json`.
3. Resolve these config values with sensible defaults if missing:
   - `taskBoardFile` → `docs/05-live-task-board.md`
   - `handoffFile` → `.claude/specbios-session.local.md`
   - `recoveryReadOrder` →
     1. `.claude/specbios-session.local.md`
     2. `docs/05-live-task-board.md`
     3. `docs/04-roadmap-and-progress.md`
     4. `docs/03-scope-and-mvp.md`
     5. `docs/01-architecture.md`
     6. `docs/00-project-dossier.md`
     7. `docs/02-data-model-and-apis.md`
4. Read the task board file.
   - If the file does not exist, tell the user the task board is missing and stop.
5. Parse the section `机器可解析任务区（权威任务源）`.
   - If the section is missing, tell the user the task board format is invalid and stop.
6. Identify the target task:
   - If `$ARGUMENTS` contains a task id like `T-005`, use that task.
   - If the specified task does not exist, tell the user and stop.
   - If the specified task is already `[completed]`, ask the user to reopen it explicitly before dispatching it.
   - Otherwise prefer the current single `[in_progress]` task.
   - If more than one task is `[in_progress]`, ask the user which one to continue instead of guessing.
   - If none is `[in_progress]`, use the first `[pending]` task and mark it `[in_progress]` first.
   - If there is no `[pending]` or `[in_progress]` task, tell the user all tasks are already completed and stop.
   - If a specific `[pending]` task is requested while another task is already `[in_progress]`, ask the user whether to switch tasks before changing the board.
7. Before execution, read files in `recoveryReadOrder` when they exist.
   - Read the handoff file first if present.
   - Then read the task board.
   - Then read the roadmap/scope/architecture/dossier/data docs that exist.
   - Do not fail just because some optional context files are missing.
8. Before acting on the task, write a concise checkpoint into the handoff file.
   - Include: current task, last checkpoint time/purpose, next atomic step, blockers, touched files, open questions.
   - Keep it short and overwrite the previous handoff content instead of appending chat-like history.
9. Execute only the requested task, staying inside the documented scope.
10. If the task is ambiguous, under-specified, or conflicts with the docs, ask the user a concise clarification question instead of guessing.
11. When done:
   - mark the task as `[completed]` in the task board
   - update the handoff file again so it reflects the latest stop point
   - if another pending task exists, record it as the likely next task in the handoff
   - only refresh human-readable summary text in the task board if it has become clearly misleading
   - tell the user what was completed
   - suggest running `/specbios-dispatch` again for the next task

Important:
- Do not add extra features.
- Respect the docs as the source of truth.
- Treat the machine-parseable task section as the only authoritative task state.
- Do not silently repair unrelated task-board inconsistencies.
