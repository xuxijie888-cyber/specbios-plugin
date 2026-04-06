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
3. Parse the section `机器可解析任务区（权威任务源）`.
4. Extract tasks in the format:
   - `- [pending] T-001 ...`
   - `- [in_progress] T-002 ...`
   - `- [completed] T-003 ...`
5. Present the tasks clearly using:
   - ✓ for completed
   - → for in_progress
   - ○ for pending
6. Include a final summary count: completed / pending / in_progress.
7. If an `in_progress` task exists, mention it separately as the current task.

Do not modify files.
