---
description: Update a task status in the SpecBIOS task board
argument-hint: <task-id> <pending|in_progress|completed>
allowed-tools: [Read, Edit, Write]
---

# /specbios-task-update

Update a task status in `docs/05-live-task-board.md`.

## Arguments

The user invoked this command with: $ARGUMENTS

## Instructions

When invoked:

1. Check whether `.specbios.json` exists. If not, tell the user this is not a SpecBIOS project and suggest `/specbios-init`.
2. Read `.specbios.json`.
3. Resolve config values with defaults if missing:
   - `taskBoardFile` → `docs/05-live-task-board.md`
   - `handoffFile` → `.claude/specbios-session.local.md`
4. Parse arguments as `<task-id> <status>`.
   - The task ID must look like `T-001`.
   - Valid statuses are: `pending`, `in_progress`, `completed`.
   - If arguments are invalid, show the correct usage.
5. Read the task board file.
   - If the file does not exist, tell the user the task board is missing.
6. Parse the section `机器可解析任务区（权威任务源）`.
   - If the section is missing, tell the user the task board format is invalid.
7. Find the target task line.
   - If the task does not exist, tell the user.
8. If the task already has the requested status, tell the user no change is needed.
9. If setting a task to `in_progress`:
   - If more than one other task is already `in_progress`, stop and ask the user to resolve the inconsistent board first.
   - If exactly one other task is already `in_progress`, warn the user and ask for confirmation before changing either task.
10. Update only the target task status token, preserving the task ID and description.
11. Keep the handoff file aligned with the new authoritative task state:
   - If the updated task becomes the only `in_progress` task, rewrite the handoff so it points to that task.
   - If the current task is marked `completed`, rewrite the handoff to show completion and the next likely pending task if one exists.
   - If the board is inconsistent, do not try to fabricate handoff state.
12. Save the file and confirm the update.

Treat the machine-parseable task section as the only task truth source.
