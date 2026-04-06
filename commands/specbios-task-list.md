---
description: List all tasks from the SpecBIOS task board
allowed-tools: [Read]
---

# /specbios-task-list

List all tasks from `docs/05-live-task-board.md`.

## Instructions

When invoked:

1. Check whether `.specbios.json` exists. If not, tell the user this is not a SpecBIOS project and suggest `/specbios-init`.
2. Read `docs/05-live-task-board.md`.
   - If the file does not exist, tell the user the task board is missing.
3. Parse the section `机器可解析任务区（权威任务源）`.
   - If the section is missing, tell the user the task board format is invalid.
4. Extract tasks only from lines in this format:
   - `- [pending] T-001 ...`
   - `- [in_progress] T-002 ...`
   - `- [completed] T-003 ...`
5. If no valid task lines are found, tell the user the task board has no parseable tasks.
6. Present the tasks clearly using:
   - ✓ for completed
   - → for in_progress
   - ○ for pending
7. Include a final summary count: completed / pending / in_progress.
8. If exactly one `in_progress` task exists, mention it separately as the current task.
9. If more than one `in_progress` task exists, warn that the board is inconsistent instead of choosing one silently.

Do not modify files.
