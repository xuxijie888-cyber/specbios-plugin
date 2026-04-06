---
name: specbios-auto-detect
trigger: session-start
---

# SpecBIOS Auto-Detection Hook

Automatically detect if the current project uses SpecBIOS and provide helpful context.

## What this does

When Claude Code starts in a directory, this hook:
1. Checks if `.specbios.json` exists
2. If found, reads the task board when available
3. Shows the current project status
4. Suggests next actions

## Trigger

This hook runs automatically when:
- Claude Code session starts in a directory
- User changes to a new directory with `.specbios.json`

## Implementation

### Detection logic

1. Check if `.specbios.json` exists in current directory.
2. If not found, do nothing.
3. If found, read the config and derive the project name.
   - If `projectName` is empty, fall back to the directory name.
   - If that is still unavailable, use `Unnamed SpecBIOS Project`.

### Context loading

1. If `docs/05-live-task-board.md` exists, read it.
2. Parse current task status from the machine-parseable section:
   - Find tasks marked `[in_progress]`
   - Count `[pending]` tasks
   - Count `[completed]` tasks
3. If the task board file or parseable section is missing, show a short warning instead of failing silently.

### User notification

If exactly one task is in progress, display a friendly message like:

```
✓ SpecBIOS project detected: [Project Name]

Current status:
  → T-007 [In Progress] 创建一个简单的 Python 计算器程序

Tasks: 2 completed, 4 pending, 1 in progress

Quick actions:
  /specbios-dispatch
  /specbios-task-list
  /specbios-task-add "description"
```

If no task is in progress, display:

```
✓ SpecBIOS project detected: [Project Name]

Tasks: 2 completed, 5 pending

Quick actions:
  /specbios-dispatch
  /specbios-task-list
```

If more than one task is in progress, mention that the task board is inconsistent and suggest `/specbios-task-list` or `/specbios-task-update`.

If the task board is missing, display a short note that the project was detected but the task board could not be loaded.

## Behavior notes

- This hook should be non-intrusive
- Only show notification once per session
- Don't block or require user interaction
- Prefer brief, actionable suggestions
