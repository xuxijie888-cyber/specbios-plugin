---
description: Add a new task to the SpecBIOS task board
argument-hint: <task description>
allowed-tools: [Read, Edit]
---

# /specbios-task-add

Add a new task to `docs/05-live-task-board.md`.

## Arguments

The user invoked this command with: $ARGUMENTS

## Instructions

When invoked:

1. Check whether `.specbios.json` exists. If not, tell the user this is not a SpecBIOS project and suggest `/specbios-init`.
2. If `$ARGUMENTS` is empty after trimming, ask the user for a task description.
3. Read `docs/05-live-task-board.md`.
   - If the file does not exist, tell the user the task board is missing and suggest re-running `/specbios-init` or restoring the file.
4. Parse the section `机器可解析任务区（权威任务源）`.
   - If the section is missing, tell the user the task board format is invalid instead of guessing where to insert.
5. Parse existing task IDs in that section and find the highest `T-XXX` number.
   - If no task IDs exist yet, start from `T-001`.
6. Create the next task ID.
7. Append a new line inside the machine-parseable section in this format:
   - `- [pending] T-XXX <task description>`
8. Preserve the existing order of tasks and do not modify any other section.
9. Save the file.
10. Reply with the new task ID and description.

Do not reorder existing tasks unless necessary.
