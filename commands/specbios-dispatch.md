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
3. Read `docs/05-live-task-board.md`.
4. Identify the target task:
   - If `$ARGUMENTS` contains a task id like `T-005`, use that task.
   - Otherwise prefer the current `[in_progress]` task.
   - If none exists, use the first `[pending]` task and mark it `[in_progress]` first.
5. Read these docs if present before acting:
   - `docs/00-project-dossier.md`
   - `docs/01-architecture.md`
   - `docs/03-scope-and-mvp.md`
   - `docs/02-data-model-and-apis.md`
6. Execute only the requested task, staying inside the documented scope.
7. When done:
   - mark the task as `[completed]` in `docs/05-live-task-board.md`
   - update the high-level summary if needed
   - tell the user what was completed
   - suggest running `/specbios-dispatch` again for the next task

Important:
- Do not add extra features.
- Respect the docs as the source of truth.
- If the task is ambiguous, ask the user a concise clarification question instead of guessing.
