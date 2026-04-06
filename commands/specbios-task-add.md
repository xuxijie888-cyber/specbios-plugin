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
2. If `$ARGUMENTS` is empty, ask the user for a task description.
3. Read `docs/05-live-task-board.md`.
4. Parse existing task IDs and find the highest `T-XXX` number.
5. Create the next task ID.
6. Add a new task line in the machine-parseable section as:
   - `- [pending] T-XXX <task description>`
7. Save the file.
8. Reply with the new task ID and description.

Do not reorder existing tasks unless necessary.
