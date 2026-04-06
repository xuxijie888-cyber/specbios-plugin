---
description: Update a task status in the SpecBIOS task board
argument-hint: <task-id> <pending|in_progress|completed>
allowed-tools: [Read, Edit]
---

# /specbios-task-update

Update task status in `docs/05-live-task-board.md`.

## Arguments

The user invoked this command with: $ARGUMENTS

## Instructions

When invoked:

1. Check whether `.specbios.json` exists. If not, tell the user this is not a SpecBIOS project and suggest `/specbios-init`.
2. Parse arguments as `<task-id> <status>`.
3. Valid statuses are: `pending`, `in_progress`, `completed`.
4. If arguments are invalid, show the correct usage.
5. Read `docs/05-live-task-board.md`.
6. Find the target task line and replace only its status.
7. If setting a task to `in_progress`, ensure there is only one `in_progress` task. If another task is already `in_progress`, warn the user and ask for confirmation before changing both.
8. Save the file and confirm the update.
